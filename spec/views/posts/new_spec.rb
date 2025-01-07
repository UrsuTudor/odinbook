require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  it "renders the form with the correct fields and data" do
    assign(:post, Post.new)
    render template: "posts/new"

    expect(rendered).to have_field("post[title]", type: "text")
    expect(rendered).to have_field("post[body]", type: "text")
    expect(rendered).to have_button("Post")
  end
end
