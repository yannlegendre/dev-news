class UserMeetup < ApplicationRecord
  belongs_to :user
  belongs_to :meetup

  validates :meetup, uniqueness: { scope: :user }
end
