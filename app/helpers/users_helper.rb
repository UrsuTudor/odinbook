module UsersHelper
  def profile_picture_form
    if @user == current_user
      form_with(model: @user, html: { multipart: true }, method: :patch, class: "profileForm") do |form|
        concat form.label(:profile_picture, "Choose Profile Picture", for: "profile_picture_upload", class: "submitBtn")
        concat form.file_field(:profile_picture, id: "profile_picture_upload", class: "hidden")
        concat form.submit("Upload profile picture", class: "submitBtn")
      end
    end
  end

  def small_user_picture(user)
    image_tag(user.profile_picture, height: "40", style: "border-radius: 50%;") if user.profile_picture.attached?
  end

  def big_user_picture
    image_tag(@user.profile_picture, height: "500", style: "border-radius: 50%;") if @user.profile_picture.attached?
  end

  def user_links(user, options = {})
    link_to user, options do
      concat small_user_picture(user)
      concat user.name
    end
  end
end
