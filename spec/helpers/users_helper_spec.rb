require "rails_helper"

RSpec.describe "UsersHelper", type: :helper do
  let(:user) { create(:user) }
  let(:mock_profile_picture) { "Sample profile picture" }

  describe "#profile_picture_form" do
    it "returns the form if the page belongs to the current_user" do
      allow(helper).to receive(:current_user).and_return(user)
      assign(:user, user)

      html = helper.profile_picture_form

      expect(html).to match("form")
      expect(html).to have_field("user[profile_picture]", type: "file")
      expect(html).to have_button("Upload profile picture")
    end
  end

  describe "#small_user_picture" do
    it 'renders an image tag when the user has a profile picture' do
      user.profile_picture.attach(
        io: File.open(Rails.root.join('spec/fixtures/profile_picture.jpg')),
        filename: 'profile_picture.jpg',
        content_type: 'image/jpg'
      )
      expect(helper.small_user_picture(user)).to include('img')
      expect(helper.small_user_picture(user)).to include('style="border-radius: 50%;"')
      expect(helper.small_user_picture(user)).to include('height="40"')
    end

    it 'returns nil when the user does not have a profile picture' do
      expect(helper.small_user_picture(user)).to be_nil
    end
  end
end
