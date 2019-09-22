class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :upvotes
  has_many :comments
  has_many :user_meetups
  has_many :meetups, through: :user_meetups

end
