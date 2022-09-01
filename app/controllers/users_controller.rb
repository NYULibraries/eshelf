# The users controller manages a user's tags, offers one action:
#   - :tags - display the list of user tags as html, json or xml
#
# Author::    scotdalton
# Copyright:: Copyright (c) 2013 New York University
# License::   Distributes under the same terms as Ruby
class UsersController < ApplicationController
  respond_to :json, :html, :xml

  # Display the tags for the current user.
  def tags
    return head :unauthorized unless current_user
    @tags = current_user.owned_tags.where("name like ?", "%#{params[:tag]}%").
      page(params[:page]).per(20)
    if @tags.empty?
      @tags = [current_user.owned_tags.new(name: I18n.t('record.tag_list.no_tags'))]
    end
    respond_with(@tags)
  end
end
