require 'rails_helper'

RSpec.describe "comments/_form", type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment) }

  it "renders the form with the correct fields and data" do
    allow(view).to receive(:current_user).and_return(user)

    render partial: "comments/form", locals: { comment: comment, post: post }

    expect(rendered).to have_field("comment[user_id]", type: "hidden", with: user.id)
    expect(rendered).to have_field("comment[post_id]", type: "hidden", with: post.id)
    expect(rendered).to have_field("comment[body]", type: "text")
    expect(rendered).to have_button("Comment")
  end
end
