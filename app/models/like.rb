class Like < ApplicationRecord
  validates_uniqueness_of :user_id, scope: :post_id
  validates :user_id, presence: true
  validates :post_id, presence: true

  belongs_to :user
  belongs_to :post
end
