class PostsController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
    @follow_requests = FollowRequest.where(sender: current_user, recipient: @users).pluck(:recipient_id)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
