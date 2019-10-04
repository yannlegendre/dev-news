require 'rails_helper'

describe ApiCaller do
  api = ApiCaller.new(themes: "wild code")

  it "should create an instance of Api Caller" do
    expect(api.themes.count).to eq 2
    expect(api.themes).to include("wild", "code")
  end

  context "EventBrite API" do
    before(:all) do
      @result = api.call_eventbrite
    end

    it "should return a hash" do
      expect(@result).to be_a Hash
    end

    it "should call the right url" do
      expect(@result[:search_url]).to eq "https://www.eventbriteapi.com/v3/events/search?q=wild%20code"
    end
    it "result hash should contain event title"
    it "result hash should contain event date"
    it "result hash should contain event location"
    it "if no result, should return a specifid hash"
  end
end
