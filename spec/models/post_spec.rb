require "rails_helper"

describe Post do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(300) }

    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(40000) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key('user_id') }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
  end
end
