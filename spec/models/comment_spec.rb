require "rails_helper"

describe Comment do
  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key('user_id') }
    it { should belong_to(:post) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
  end

  describe 'factory' do
    it 'is valid with valid attributes' do
      comment = FactoryBot.create(:comment)
      expect(comment).to be_valid
    end

    it 'is invalid without a body' do
      comment = FactoryBot.build(:comment, body: nil)
      expect(comment).not_to be_valid
      expect(comment.errors[:body]).to include("can't be blank")
    end
  end
end
