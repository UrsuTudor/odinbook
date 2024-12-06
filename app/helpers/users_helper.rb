module UsersHelper
  def profile_picture_form
    if @user == current_user
      form_with(model: @user, html: { multipart: true }, method: :patch) do |form|
        concat form.file_field :profile_picture
        concat form.submit "Upload profile picture"
      end
    end
  end

  def small_user_picture(user)
    image_tag(user.profile_picture, height: "40", style: "border-radius: 50%;") if user.profile_picture.attached?
  end

  def big_user_picture
    image_tag(@user.profile_picture, height: "300", style: "border-radius: 50%;") if @user.profile_picture.attached?
  end

  def user_links(user)
    link_to user do
      concat small_user_picture(user)
      concat user.name
    end
  end
end
