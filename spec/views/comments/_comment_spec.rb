require 'rails_helper'

RSpec.describe "comments/_comment", type: :view do
  let(:user) { create(:user, name: "Eve") }
  let(:comment) { create(:comment, author: user) }

  it "renders attributes in show page" do
    render partial: "comments/comment", locals: { comment: comment }

    expect(rendered).to match(/Eve/)
    expect(rendered).to match(comment.body)
  end
end
