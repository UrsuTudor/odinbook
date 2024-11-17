class Post < ApplicationRecord
  # validates title:, presence: true, length: { maximum: 300 }
  # validates body:, presence: true, length: { maximum: 40000 }

  def index
    @posts = Post.all
  end
end
