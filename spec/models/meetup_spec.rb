require 'rails_helper'

describe Meetup do
  before(:each) do
    @meetup = create(:meetup)
  end

  context 'Validations' do
    it "has a valid factory" do
      expect(@meetup).to be_valid
    end
    it "is invalid without a date and time" do
      expect(build(:meetup, date_time: nil)).to_not be_valid
    end
    it "is invalid without a title" do
      expect(build(:meetup, title: nil)).to_not be_valid
    end
    it "is invalid without an url" do
      expect(build(:meetup, url: nil)).to_not be_valid
    end
  end


  context 'Associations' do
    it "has many users" do
      u1 = create(:user)
      u2 = create(:user)
      create(:user_meetup, meetup: @meetup, user: u1)
      create(:user_meetup, meetup: @meetup, user: u2)
      expect(@meetup.users.length).to eq 2
    end
    it "has many themes" do
      t1 = create(:theme)
      t2 = create(:theme)
      create(:meetup_theme, meetup: @meetup, theme: t1)
      create(:meetup_theme, meetup: @meetup, theme: t2)
      expect(@meetup.themes.length).to eq 2
    end
  end
end
