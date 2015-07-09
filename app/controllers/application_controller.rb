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
  alias :current_user :current_user_dev if Rails.env.development?

  # Alias new_session_path as login_path for default devise config
  def new_session_path(scope)
    login_path
  end

  # After signing out from the local application,
  # redirect to the logout path for the Login app
  def after_sign_out_path_for(resource_or_scope)
    if ENV['SSO_LOGOUT_URL'].present?
      ENV['SSO_LOGOUT_URL']
    else
      super(resource_or_scope)
    end
  end

  prepend_before_filter :passive_login
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

  def passive_login_url
    "#{ENV['PASSIVE_LOGIN_URL']}?client_id=#{ENV['APP_ID']}&return_uri=#{request_url_escaped}&login_path=#{login_path_escaped}"
  end

  def request_url_escaped
    CGI::escape(ensure_ssl(request.url))
  end

  def login_path_escaped
    # Force the HTTPS version of this url because doorkeeper requires it
    CGI::escape("#{ensure_ssl(Rails.application.config.action_controller.relative_url_root)}/login")
  end

  def ensure_ssl(url)
    url.gsub('http:','https:') rescue nil
  end
end
