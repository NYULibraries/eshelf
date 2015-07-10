class Users::SessionsController < Devise::SessionsController
  after_filter :records_session_maintenance, only: :create

  # Save temporary records to the current user
  # Intended to be called after validate on login
  def records_session_maintenance
    if (current_user and session[:tmp_user])
      # Find all the tmp_users records
      tmp_user.records.each do |record|
        # Don't duplicate them if the current user already saved these records
        unless current_user.records.where(external_system: record.external_system, external_id: record.external_id).present?
          # But reassign them to this current user from the tmp user
          existing_record = Record.find(record.id)
          existing_record.tmp_user = nil
          existing_record.user = current_user
          existing_record.save!
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
