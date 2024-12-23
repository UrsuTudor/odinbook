require "rails_helper"

describe Like do
  describe 'validations' do
    subject { FactoryBot.create(:like) }

    it { should validate_uniqueness_of(:user_id).scoped_to(:post_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:post_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
