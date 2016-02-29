# The users controller manages a user's account and tags,
# and offers a set of actions:
#   - :account - wraps the display of the user's Aleph account as html
#   - :tags - display the list of user tags as html, json or xml
#
# Author::    scotdalton
# Copyright:: Copyright (c) 2013 New York University
# License::   Distributes under the same terms as Ruby
class UsersController < ApplicationController
  respond_to :json, :xml, except: :account
  respond_to :html

  # Display the Aleph account for the current user.
  def account
    return if performed?
    # Log into PDS directly since that is required
    # for the Aleph account option
    if cookies[:_pds_logged_in].nil?
      cookies[:_return_to_account] = true
      cookies[:_pds_logged_in] = true
      redirect_to pds_login and return
    elsif !current_user.nil?
      respond_with(current_user)
    else
      head :bad_request
    end
  end

  # Display the tags for the current user.
  def tags
    return head :unauthorized unless current_user
    @tags = current_user.owned_tags.where("name like ?", "%#{params[:tag]}%").
      page(params[:page]).per(20)
    respond_with(@tags)
  end

  private

  def pds_login
    "#{ENV['PDS_URL']}/pds?func=load-login&institute=#{current_primary_institution.code}&calling_system=eshelf&url=#{CGI::escape(passive_login_url)}"
  end

end
