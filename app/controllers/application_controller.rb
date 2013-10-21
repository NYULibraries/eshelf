# The application manages a user's set of saved record,
#
# Author::    scotdalton
# Copyright:: Copyright (c) 2013 New York University
# License::   Distributes under the same terms as Ruby
class ApplicationController < ActionController::Base
  before_filter :set_wayfinder
  protect_from_forgery
  require 'authpds'
  include Authpds::Controllers::AuthpdsController
  layout Proc.new { |controller| (controller.request.xhr?) ? false : "eshelf" }

  # For dev purposes
  def current_user_dev
    @current_user_dev ||= User.find_by_username("developer")
  end
  alias :current_user :current_user_dev if Rails.env.development?

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
    @user_records ||= user.records.sorted(current_sort).scoped
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
end
