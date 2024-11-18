class FollowRequest < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"

  def self.create_request(sender, recipient)
    create(sender: sender, recipient: recipient, status: "pending")
  end
end
