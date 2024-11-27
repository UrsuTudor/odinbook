class PostsController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
    @sent_follow_requests = FollowRequest.where(sender: current_user, recipient: @users).pluck(:recipient_id)
    @received_follow_requests = FollowRequest.includes(:sender).where(sender: @users, recipient: current_user, status: "pending")

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
