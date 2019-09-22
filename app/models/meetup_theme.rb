class MeetupTheme < ApplicationRecord
  belongs_to :meetup
  belongs_to :theme

  validates :meetup, uniqueness: { scope: :theme }

end
