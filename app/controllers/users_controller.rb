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

# Unfollowing:
# - button next to person saying 'unfollow'
# - unfollow has to:
#  - remove the followers/followee relationship
#  - delete the initial follow request (or update it with a 'unfollowed' status, but the first option is easier for the small scope of this and especially since I have no reason to track follow request history)
