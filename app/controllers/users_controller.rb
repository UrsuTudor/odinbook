class UsersController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

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
