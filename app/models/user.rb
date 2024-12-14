class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :age, numericality: { only_integer: true }

  has_and_belongs_to_many :followers, class_name: "User", join_table: "users_followers_followees", foreign_key: "followee_id", association_foreign_key: "follower_id"
  has_and_belongs_to_many :followees, class_name: "User", join_table: "users_followers_followees", foreign_key: "follower_id", association_foreign_key: "followee_id"

  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id"
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id"

  has_one_attached :profile_picture

  has_many :posts
  has_many :likes
  has_many :comments

  after_commit :send_welcome_email, on: :create

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_later
  end
end
