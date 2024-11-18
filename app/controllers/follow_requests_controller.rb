class FollowRequestsController < ApplicationController
  def create
    recipient = User.find(params[:recipient_id])
    FollowRequest.create_request(current_user, recipient)
  end
end
