class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @post = Post.find(params[:like][:post_id])

    respond_to do |format|
      if @like.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("like_button_#{@post.id}", partial: "likes/unlike_form", locals: { post: @post, like: @like }),
            turbo_stream.update("likes_#{@post.id}", @post.likes.count) ]
        end
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:like][:post_id])
    @like = Like.find(params[:id])
    respond_to do |format|
      if @like.destroy
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("like_button_#{@post.id}", partial: "likes/form", locals: { post: @post, like: @like }),
            turbo_stream.update("likes_#{@post.id}", @post.likes.count) ]
        end
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end
end
