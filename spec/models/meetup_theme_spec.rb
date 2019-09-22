require 'rails_helper'

RSpec.describe MeetupTheme, type: :model do
  it "a theme can only be added once to a specific meetup" do
    theme = create(:theme)
    meetup = create(:meetup)
    create(:meetup_theme, theme: theme, meetup: meetup)
    meetuptheme2 = build(:meetup_theme, theme: theme, meetup: meetup)
    meetuptheme2.validate
    expect(meetuptheme2.errors.messages[:meetup]).to include("has already been taken")
  end
end
