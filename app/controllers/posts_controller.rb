class PostsController < ApplicationController
  def index
    @posts = Post.where(author: [ current_user ] + current_user.followees).shuffle
    @post = current_user.posts.new
    @users = User.where.not(id: current_user.id)
    @sent_follow_requests = FollowRequest.where(sender: current_user, recipient: @users).pluck(:recipient_id)
    @received_follow_requests = FollowRequest.includes(:sender).where(sender: @users, recipient: current_user, status: "pending")
    @like = Like.new
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
