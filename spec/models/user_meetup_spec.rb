require 'rails_helper'

RSpec.describe UserMeetup, type: :model do
  it "a user can only attend once to a specific meetup" do
    user = create(:user)
    meetup = create(:meetup)
    create(:user_meetup, user: user, meetup: meetup)
    usermeetup2 = build(:user_meetup, user: user, meetup: meetup)
    usermeetup2.validate
    expect(usermeetup2.errors.messages[:meetup]).to include("has already been taken")
  end
end
