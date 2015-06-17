require 'authpds'
class UserSessionsController < ApplicationController
  # Handle session maintenance after validation
  after_filter :records_session_maintenance, only: :validate
  include Authpds::Controllers::AuthpdsSessionsController

  # Save temporary records to the current user
  # Intended to be called after validate on login
  def records_session_maintenance
    if (current_user and session[:tmp_user])
      # Find all the tmp_users records
      tmp_user.records.each do |record|
        # Don't duplicate them if the current user already saved these records
        unless current_user.records.where(external_system: record.external_system, external_id: record.external_id).present?
          # But reassign them to this current user from the tmp user
          record.tmp_user = nil
          record.user = current_user
          record.save!
        end
      end
      # Get rid of the tmp user for the session
      session.delete(:tmp_user)
      # Reload from the DB, so we don't destroy the
      # records we just saved.
      tmp_user.records.reload
      # Sweep the leg
      tmp_user.destroy
    end
  end
end
