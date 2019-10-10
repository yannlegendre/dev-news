require 'rails_helper'

describe ApiCaller do
  api = ApiCaller.new(themes: "wild code")
  api_one_word = ApiCaller.new(themes: "code")

  it "should create an instance of Api Caller" do
    expect(api.themes.count).to eq 2
    expect(api.themes).to include("wild", "code")
  end

  context "EventBrite API" do
    before(:all) do
      # @result = api_one_word.call_eventbrite
      @result = api_one_word.simulate_call
      @search_url = "https://www.eventbriteapi.com/v3/events/search?q=code"
      @sim = api_one_word.make_event(@result)
    end

    it "should call the right url" do
      expect(@result[:search_url]).to eq @search_url
    end

    it "api call should return hash containing events" do
      expect(@result[:events].count).to be > 0
    end

    it "result hash should contain event title" do
      expect(@result[:events].first["name"]["text"]).to be_a String
    end

    it "result hash should contain event date" do
      expect(@result[:events].first["start"]["local"]).to be_a String
    end

    it "result hash should contain event url" do
      expect(@result[:events].first["url"]).to be_a String
    end

    it "result hash should contain event location"
    it "if no result, should return a specifid hash"
  end
end
