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
  def account_render
    unless current_user.nil?
      respond_with(current_user) do |format|
        format.html { render :account }
      end
    else
      redirect_to user_account_path
    end
  end

  def account
    # Log into PDS directly since that is required
    # for the Aleph account option
    if !cookies[:_pds_logged_in].present?
      cookies[:_return_to_account] = true
      cookies[:_pds_logged_in] = true
      redirect_to pds_login
    elsif cookies[:_pds_logged_in]
      cookies.delete(:_pds_logged_in)
      redirect_to user_account_render_path
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
