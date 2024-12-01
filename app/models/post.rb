class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 300 }
  validates :body, presence: true, length: { maximum: 40000 }

  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :likes
end
