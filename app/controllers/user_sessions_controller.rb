require 'authpds'
class UserSessionsController < ApplicationController
  # Handle session maintenance after validation
  after_filter :records_session_maintenance, only: :validate
  include Authpds::Controllers::AuthpdsSessionsController

  # Save temporary records to the current user
  # Intended to be called after validate on login
  def records_session_maintenance
    if (current_user and session[:tmp_user])
      tmp_user_records = tmp_user.records.reject do |record|
        current_user.records.where(external_system: record.external_system, external_id: record.external_id).present?
      end
      tmp_user_records.each do |record|
        # This is a CRAZY hack.
        # This can't really be necessary.
        # Needs further investigation.
        # Basically, ActiveRecords insists on making this an
        # insert even though a simple key switch would do.
        # record.id = nil
        record.tmp_user = nil
        record.user = current_user
        record.save
      end
      # current_user.records.reload << tmp_user_records
      current_user.save!
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
