require "rails_helper"

RSpec.describe "Likes", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "POST create" do
    it "saves post with valid params and responds with turbo_stream" do
      expect {
        post posts_path, params: { post: { title: "title", body: "body" } }, as: :turbo_stream
    }.to change { Post.count }.by(1)

    expect(response.body).to include("turbo-stream")
    end

    it "doesn't save a post with missing title" do
      expect {
        post posts_path, params: { post: { title: "", body: "body" } }, as: :turbo_stream
      }.not_to change { Post.count }

      expect(response).to have_http_status(422)
    end

    it "doesn't save a post with missing body" do
      expect {
        post posts_path, params: { post: { title: "title", body: "" } }, as: :turbo_stream
      }.not_to change { Post.count }

      expect(response).to have_http_status(422)
    end
  end
end
