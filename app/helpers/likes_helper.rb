module LikesHelper
  def liked?(post)
    if Like.find_by(user_id: current_user.id, post_id: post.id)
      true
    else
      false
    end
  end

  def like_button(post)
    if liked?(post)
      # without the additional query for the Like, the page won't know which like model to load for the unlike method,
      # since it normally gets that from the controller via turbo_stream
      render partial: "likes/unlike_form", locals: { post: post, like: (Like.find_by(user_id: current_user.id, post_id: post.id)) }
    else
      render partial: "likes/form", locals: { post: post }
    end
  end
end
