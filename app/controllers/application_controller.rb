# The application manages a user's set of saved record,
#
# Author::    scotdalton
# Copyright:: Copyright (c) 2013 New York University
# License::   Distributes under the same terms as Ruby
class ApplicationController < ActionController::Base
  include Nyulibraries::Assets::InstitutionsHelper
  before_filter :set_wayfinder
  protect_from_forgery

  layout Proc.new { |controller| (controller.request.xhr?) ? false : "eshelf" }

  # For dev purposes
  def current_user_dev
    @current_user_dev ||= User.find_by_username("hero123")
  end
  # alias :current_user :current_user_dev if Rails.env.development?

  # Alias new_session_path as login_path for default devise config
  def new_session_path(scope)
    login_path
  end

  # After signing out from the local application,
  # redirect to the logout path for the Login app
  def after_sign_out_path_for(resource_or_scope)
    if logout_path.present?
      logout_path
    else
      super(resource_or_scope)
    end
  end

  def after_sign_in_path_for(resource)
    records_session_maintenance
    if cookies[:_nyulibraries_eshelf_passthru] && ENV['PASSTHRU_LOGIN_PATH']
      "#{ENV['LOGIN_URL']}#{ENV['PASSTHRU_LOGIN_PATH']}"
    elsif cookies[:_return_to_account]
      cookies.delete(:_return_to_account)
      account_path({ institution: current_primary_institution.code })
    else
      super(resource)
    end
  end

  prepend_before_filter :passive_login, unless: -> { ignore_passive_login? }
  def passive_login
    if !cookies[:_check_passive_login]
      cookies[:_check_passive_login] = true
      redirect_to passive_login_url
    end
  end

  # Returns the session's TmpUser
  # Sets the sessions' TmpUser if necessary.
  def tmp_user
    @tmp_user ||= (session[:tmp_user].blank?) ? (session[:tmp_user] = TmpUser.create) : session[:tmp_user]
  end
  private :tmp_user

  # Returns the User or TmpUser associated with this session
  def user
    @user ||= (current_user.nil?) ? tmp_user : current_user
  end
  helper_method :user

  # Returns an ActiveRecord relation of the user's record
  def user_records
    @user_records ||= user.records.sorted(current_sort)
  end
  helper_method :user_records

  # Need to double escape quotes for ActsAsTaggableOn due to this RegEx.
  # https://github.com/mbleigh/acts-as-taggable-on/blob/master/lib/acts_as_taggable_on/tag_list.rb#L26
  def double_escape_quotes(s)
    s.gsub(/\"/, "\"\"") unless s.nil?
  end
  protected :double_escape_quotes

  # Wayfinder for the given request
  def wayfinder
    @wayfinder ||= Wayfinder.new(request)
  end
  alias :set_wayfinder wayfinder
  helper_method :wayfinder

  # Returns the current sort
  # Default sort is newest first.
  def current_sort
    @current_sort ||= (params[:sort]||"created_at_desc")
  end
  helper_method :current_sort

 private

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

  def logout_path
    if ENV['LOGIN_URL'].present? && ENV['SSO_LOGOUT_PATH'].present?
      "#{ENV['LOGIN_URL']}#{ENV['SSO_LOGOUT_PATH']}"
    end
  end

  def passive_login_url
    "#{ENV['LOGIN_URL']}#{ENV['PASSIVE_LOGIN_PATH']}?client_id=#{ENV['APP_ID']}&return_uri=#{request_url_escaped}"
  end

  def request_url_escaped
    CGI::escape(ensure_ssl(request.url))
  end

  def ensure_ssl(url)
    url.gsub('http:','https:') rescue nil
  end

  # Attempt to perform passive login except in the following cases:
  # 1- If format is JS or JSON
  # 2- If user is already signed in- this is only relevant for eshelf because
  #    Login will redirect and login to eshelf automatically
  # 3- If action is /account - in this case the application forces
  #    you to login so there is not need for passive
  # 4- If _nyulibraries_eshelf_passthru cookie is set we are on passthru phase
  #    and shouldn't have to check for passive login
  def ignore_passive_login?
    (request.format.js? ||
    request.format.json? ||
    user_signed_in? ||
    action_name == 'account' ||
    cookies[:_nyulibraries_eshelf_passthru])
  end
end
