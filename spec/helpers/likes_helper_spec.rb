require "rails_helper"

RSpec.describe "LikesHelper", type: :helper do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:like) { create(:like, user: user, post: post) }

  describe "#liked?" do
    before do
      allow(helper).to receive(:current_user).and_return(user)
    end

    it "returns true if the user has liked the post" do
      like
      expect(helper.liked?(post)).to eq(true)
    end

    it "returns false if the user has not liked the post" do
      expect(helper.liked?(post)).to eq(false)
    end
  end

  describe "#like_button" do
    before do
      allow(helper).to receive(:current_user).and_return(user)
    end

    it 'renders the unlike_form if post is already liked' do
      like
      allow(helper).to receive(:render).and_call_original
      helper.like_button(post)
      expect(helper).to have_received(:render).with(partial: 'likes/unlike_form', locals: { post: post, like: like })
    end

    it 'renders the like_form if post is already liked' do
      allow(helper).to receive(:render).and_call_original
      helper.like_button(post)
      expect(helper).to have_received(:render).with(partial: 'likes/form', locals: { post: post, like: an_instance_of(Like) })
    end
  end
end
