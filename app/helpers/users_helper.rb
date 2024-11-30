module UsersHelper
  def edit_profile_picture
    if @user == current_user
      form_with(model: @user, html: { multipart: true }, method: :patch) do |form|
        concat form.file_field :profile_picture
        concat form.submit "Upload profile picture"
      end
    end
  end
end
