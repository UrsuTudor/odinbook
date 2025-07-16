class UsersController < ApplicationController
  def show
    # instanttiating a @comment variable here is the easiest way to ensure that the user#show view will have access to it
    # given how many views and components link to it.
    @comment = Comment.new
    @user = User.find(params[:id])
    @sent_requests = current_user.sent_follow_requests.pluck(:recipient_id)
  end

  def update
    @user = User.find(params[:id])

    @user.update(user_params)
    redirect_to @user
  end

  def accept_follow_request
    ActiveRecord::Base.transaction do
      # Changes relationship between users
      follower = User.find(params[:follower_id])
      follower.followees << current_user

      # Updates request status
      request = FollowRequest.find(params[:request_id])
      request.update!(status: "accepted")
    end
  end

  def reject_follow_request
    request = FollowRequest.find(params[:request_id])
    request.update(status: "rejected")
  end

  def unfollow
    ActiveRecord::Base.transaction do
      followee = User.find(params[:followee_id])
      followee.followers.delete(current_user)
      current_user.followees.delete(followee)

      FollowRequest.delete_request(current_user.id, params[:followee_id])
    end

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :city, :profile_picture, :age)
  end
end
