require "rails_helper"

RSpec.describe "FollowReuqestsHelper", type: :helper do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  context "follow_request_decision_form" do
    it "generates a form with the correct arguments" do
      request = create(:follow_request)
      html = helper.follow_request_decision_form("/some_url", request, "Accept", "click->action", "target")

      expect(html).to include('form')
      expect(html).to have_field("follower_id", type: "hidden", with: request.sender.id)
      expect(html).to have_field("request_id", type: "hidden", with: request.id)
      expect(html).to have_selector("input[type='submit'][value='Accept'][data-action='click->action'][data-target='target']")
    end
  end

  context "follow_request_form" do
    it "generates a follow_request form if the current user has not sent a request to the other user" do
      html = helper.follow_request_form(user1, [])

      expect(html).to include('form')
      expect(html).to have_field("recipient_id", type: "hidden", with: user1.id)
      expect(html).to have_button("Send Follow Request")
    end

    it "doesn't generates a follow_request form if the current user has not sent a request to the other user" do
      html = helper.follow_request_form(user1, [ user1.id ])

      puts html
      expect(html).not_to have_field("recipient_id", type: "hidden", with: user1.id)
      expect(html).not_to have_button("Send Follow Request")
    end
  end

  context "unfollow_button" do
    before do
      allow(helper).to receive(:current_user).and_return(user1)
    end

    it "generates an unfollow button if the current_user already follows user2" do
      user1.followees << user2
      html = helper.unfollow_button(user2)

      expect(html).to have_field("followee_id", type: "hidden", with: user2.id)
      expect(html).to have_button("Unfollow")
    end

    it "doesn't generates an unfollow button if the current_user isn't following user2" do
      html = helper.unfollow_button(user2)

      expect(html).not_to have_field("followee_id", type: "hidden", with: user2.id)
      expect(html).not_to have_button("Unfollow")
    end
  end
end
