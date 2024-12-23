require "rails_helper"

describe FollowRequest do
  describe 'associations' do
    it { should belong_to(:sender).class_name('User').with_foreign_key(:sender_id) }
    it { should belong_to(:recipient).class_name('User').with_foreign_key(:recipient_id) }
  end

  describe '.create_request' do
    let(:sender) { FactoryBot.create(:user) }
    let(:recipient) { FactoryBot.create(:user) }

    it 'creates a follow request with the correct attributes' do
      follow_request = FollowRequest.create_request(sender, recipient)

      expect(follow_request).to be_persisted
      expect(follow_request.sender).to eq(sender)
      expect(follow_request.recipient).to eq(recipient)
      expect(follow_request.status).to eq('pending')
    end
  end

  describe '.delete_request' do
    let(:sender) { FactoryBot.create(:user) }
    let(:recipient) { FactoryBot.create(:user) }
    let!(:follow_request) { FollowRequest.create(sender: sender, recipient: recipient, status: 'pending') }

    it 'deletes the follow request if it exists' do
      expect { FollowRequest.delete_request(sender, recipient) }.to change { FollowRequest.count }.by(-1)
      expect(FollowRequest.find_by(sender: sender, recipient: recipient)).to be_nil
    end
  end
end
