require 'rails_helper'

RSpec.describe "posts/_post", type: :view do
  let(:user) { create(:user, name: "Eve") }
  let(:post) { create(:post, author: user, comments: [ comment ]) }
  let(:comment) { create(:comment, author: user) }

  it "renders post" do
    allow(view).to receive(:current_user).and_return(user)

    render partial: "posts/post", locals: { post: post }

    expect(rendered).to match(/Eve/)
    expect(rendered).to match(post.body)
    expect(rendered).to match(post.likes.count.to_s)
    expect(rendered).to match(comment.author.name)
  end
end
