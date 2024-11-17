class UsersController < ApplicationController
  def follow
    followee = User.find(params[:id])
    followee.followers << current_user
    current_user.followees << followee
  end

  def unfollow
    followee = User.find(params[:id])
    followee.followers.delete(current_user)
    current_user.followees.delete(followee)
  end
end
