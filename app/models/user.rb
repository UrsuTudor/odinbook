class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :age, numericality: { only_integer: true }

  has_many :followers, class_name: "User", foreign_key: "follower_id"
  belongs_to :follower, class_name: "User", optional: true

  has_many :followees, class_name: "User", foreign_key: "followee_id"
end
