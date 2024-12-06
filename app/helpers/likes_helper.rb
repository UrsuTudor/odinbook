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
      # without instantiating a new Like here, the form will not generate properly when a new post is created and attached
      # to the DOM via turbo_stream
      render partial: "likes/form", locals: { post: post, like: (Like.new) }
    end
  end
end
