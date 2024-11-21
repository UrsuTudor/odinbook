class UsersController < ApplicationController
  def index
  end

  def accept_follow_request
    # changes relationship between users
    follower = User.find(params[:follower_id])
    follower.followees << current_user
    current_user.followers << follower

    # updates request status
    request = FollowRequest.find(params[:request_id])
    request.update(status: "accepted")
  end

  def reject_follow_request
    request = FollowRequest.find(params[:request_id])
    request.update(status: "rejected")
  end

  def unfollow
    followee = User.find(params[:id])
    followee.followers.delete(current_user)
    current_user.followees.delete(followee)
  end
end
