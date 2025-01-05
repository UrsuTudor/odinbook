require "rails_helper"

RSpec.describe "FollowRequests", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:recipient) { create(:user) }

  before do
    sign_in user
  end

  describe "POST create" do
    it "creates a follow request" do
      expect {
        post follow_requests_path(recipient_id: recipient.id)
    }.to change { FollowRequest.count }.by(1)
    end
  end
end
