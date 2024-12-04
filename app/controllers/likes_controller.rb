class LikesController < ApplicationController
  def new
    @like = Like.new
  end
  def create
    @like = Like.new(post_id: params[:like][:post_id], user_id: params[:like][:user_id])
    @post = Post.find(params[:like][:post_id])

    respond_to do |format|
      if @like.save
        format.turbo_stream
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end
end
