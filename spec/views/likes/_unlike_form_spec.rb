require 'rails_helper'

RSpec.describe "likes/_unlike_form", type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:like) { create(:like) }

  it "renders the form with the correct fields and data" do
    allow(view).to receive(:current_user).and_return(user)

    render partial: "likes/unlike_form", locals: { like: like, post: post }

    expect(rendered).to have_field("like[user_id]", type: "hidden", with: user.id)
    expect(rendered).to have_field("like[post_id]", type: "hidden", with: post.id)
    expect(rendered).to have_button("Unlike")
  end
end
