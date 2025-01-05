require "rails_helper"

RSpec.describe "Likes", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:mock_post) { create(:post) }

  before do
    sign_in user
  end

  describe "POST create" do
    it "creates a like with valid params" do
      expect {
        post likes_path, params: { like: { post_id: mock_post.id, user_id: user.id } }
      }.to change { Like.count }.by(1)
    end

    it "doesn't create a like with invalid params" do
      post likes_path, params: { like: { post_id: mock_post.id } }
      expect(response).to have_http_status(422)
    end
  end

  describe "DELETE destroy" do
    it "deletes the like and responds with turbo_stream" do
       like = create(:like, post: mock_post, user: user)

      expect {
        delete like_path(like.id), params: { like: { post_id: mock_post.id } }, as: :turbo_stream
      }.to change { Like.count }.by(-1)

      expect(response).to have_http_status(200)
      expect(response.body).to include("turbo-stream")
    end

    it "fails if the like isn't found" do
      like = 999

     expect {
       delete like_path(like), params: { like: { post_id: mock_post.id } }, as: :turbo_stream
     }.to change { Like.count }.by(0)

     expect(response).to have_http_status(404)
   end
  end
end
