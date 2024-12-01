class LikesController < ApplicationController
  def create
    Like.create(post_id: params[:like][:post_id], user_id: params[:like][:user_id])
  end
end
