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
    if current_user.blank?
      redirect_to(login_url({ institution: current_primary_institution.code, return_url: request.url })) and return
    else
      respond_with(current_user)
    end
  end

  # Display the tags for the current user.
  def tags
    return head :unauthorized unless current_user
    @tags = current_user.owned_tags.where("name like ?", "%#{params[:tag]}%").
      page(params[:page]).per(20)
    respond_with(@tags)
  end
end
