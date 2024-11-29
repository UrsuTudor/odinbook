class FollowRequest < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"

  def self.create_request(sender, recipient)
    create(sender: sender, recipient: recipient, status: "pending")
  end

  def self.delete_request(sender, recipient)
    find_by(sender: sender, recipient: recipient)&.destroy
  end
end
