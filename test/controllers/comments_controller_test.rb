require "test_helper"

describe CommentsController do
  it "gets new" do
    get comments_new_url
    must_respond_with :success
  end

  it "gets create" do
    get comments_create_url
    must_respond_with :success
  end
end
