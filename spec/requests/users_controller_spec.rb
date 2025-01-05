require "rails_helper"


RSpec.describe "Likes", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:follower) { create(:user) }
  let(:followee) { create(:user) }
  let(:follow_request) { create(:follow_request, sender: follower, recipient: followee) }

  before do
    sign_in user
  end

  describe "GET show" do
    it "shows the user profile for the current user" do
      get user_path(user)

      expect(response).to have_http_status(200)
      expect(response.body).to include(user.name)
    end
  end

  describe "accept_follow_request" do
    it "establishes follower - followee relationship with valid params" do
      sign_in followee
      expect(followee.followers.first).not_to eq(follower)

      post accept_follow_request_user_path(followee), params: { follower_id: follower.id, request_id: follow_request.id }
      follow_request.reload

      expect(followee.followers.first).to eq(follower)
      expect(follower.followees.first).to eq(followee)
      expect(follow_request.status).to eq("accepted")
    end
  end

  describe "reject_follow_request" do
    it "correctly rejects a follow request" do
      sign_in followee
      post reject_follow_request_user_path(followee), params: { follower_id: follower.id, request_id: follow_request.id }
      follow_request.reload

      expect(followee.followers.first).not_to eq(follower)
      expect(follower.followees.first).not_to eq(followee)
      expect(follow_request.status).to eq("rejected")
    end
  end

  describe "unfollow" do
    it "removes follower - followee relationship" do
      sign_in follower
      expect(followee.followers.first).not_to eq(follower)

      post accept_follow_request_user_path(followee), params: { follower_id: follower.id, request_id: follow_request.id }

      delete unfollow_user_path(follower.id), params: { followee_id: followee.id }
      expect(followee.followers.first).not_to eq(follower)
      expect(follower.followees.first).not_to eq(followee)
      expect(FollowRequest.exists?(follow_request.id)).to be(false)
    end
  end
end
