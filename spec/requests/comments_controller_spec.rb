require 'rails_helper'

RSpec.describe "Comments", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:mock_post) { create(:post) }
  let(:valid_body) { "valid comment body" }
  let(:invalid_body) { '' }

  before do
    sign_in user
  end

  describe "POST create" do
    it "saves comment with valid params" do
      expect {
        post comments_path, params: { comment: { body: valid_body, user_id: user.id, post_id: mock_post.id } }, as: :turbo_stream
      }.to change { Comment.count }.by(1)
    end

    it "doesn't save comment with invalid params" do
      post comments_path, params: { comment: { body: invalid_body, user_id: user.id, post_id: mock_post.id } }, as: :turbo_stream
      expect(response).to have_http_status(422)
    end
  end
end
