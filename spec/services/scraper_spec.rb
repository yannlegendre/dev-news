require 'rails_helper'

describe Scraper do
  def expect_results
    expect(@res[:list].size).to be > 0
  end

  medium_ruby_rails = Scraper.new(themes: ["ruby", "rails"])
  before(:all) do
    @res = medium_ruby_rails.scrape_medium
  end

  it "should create a scraper for medium with keywords ruby and rails" do
    expect(medium_ruby_rails.themes).to include("ruby", "rails")
    expect(medium_ruby_rails.themes.length).to eq 2
  end

  context "Medium scraper " do
    it "should return a hash" do
      expect(@res).to be_a Hash
    end
    it "should return the good search url" do
      expect(@res[:search_url]).to eq("https://www.medium.com/search?q=ruby%20rails")
    end
    it "post seach on url shoud return results" do
      expect_results
    end

    it "should return three hashes for three results" do
      if @res[:list].present?
        expect(@res[:list].size).to eq 3
      else
        expect_results
      end
    end

    it "each result hash should contain article url" do
      if @res[:list].present?
        expect(@res[:list].first[:url]).to be_a String
        expect(@res[:list].second[:url]).to be_a String
        expect(@res[:list].third[:url]).to be_a String
      else
        expect_results
      end
    end

    # it "each @result hash should contain article image url" do
    #   if @res[:list].present?
    #     expect(@res[:list].first[:img_url]).to be_a String
    #     expect(@res[:list].second[:img_url]).to be_a String
    #     expect(@res[:list].third[:img_url]).to be_a String
    #   else
    #     expect_results
    #   end
    # end
    it "each result hash should contain a title" do
      if @res[:list].present?
        expect(@res[:list].first[:title]).to be_a String
        expect(@res[:list].second[:title]).to be_a String
        expect(@res[:list].third[:title]).to be_a String
      else
        expect_results
      end
    end
    it "each result hash should contain article description" do
      if @res[:list].present?
        expect(@res[:list].first[:description]).to be_a String
        expect(@res[:list].second[:description]).to be_a String
        expect(@res[:list].third[:description]).to be_a String
      else
        expect_results
      end
    end
  end
end
