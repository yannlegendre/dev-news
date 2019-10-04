class Meetup < ApplicationRecord
  has_many :user_meetups
  has_many :users, through: :user_meetups
  has_many :meetup_themes
  has_many :themes, through: :meetup_themes

  validates :title, :date_time, :url, presence: true
end
