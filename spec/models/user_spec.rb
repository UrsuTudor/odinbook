require "rails_helper"

describe User do
  include ActiveJob::TestHelper

  describe 'validations' do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:age) }
  end

  describe 'associations' do
    it {
      should have_and_belong_to_many(:followers)
        .class_name('User')
        .join_table('users_followers_followees')
        .with_foreign_key('followee_id')
    }

    it {
      should have_and_belong_to_many(:followees)
        .class_name('User')
        .join_table('users_followers_followees')
        .with_foreign_key('follower_id')
    }

    it { should have_many(:sent_follow_requests).class_name('FollowRequest').with_foreign_key(:sender_id) }
    it { should have_many(:received_follow_requests).class_name('FollowRequest').with_foreign_key(:recipient_id) }

    it { should have_one_attached(:profile_picture) }

    it { should have_many("posts") }
    it { should have_many("likes") }
    it { should have_many("comments") }
  end

  describe 'callbacks' do
    it 'sends a welcome email after user creation' do
      perform_enqueued_jobs do
        user = FactoryBot.create(:user)
      end

      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
