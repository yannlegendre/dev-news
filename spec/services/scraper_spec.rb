require 'rails_helper'

describe Scraper do
  def expect_results
    expect(@res[:list].size).to be > 0
  end

  ruby_rails = Scraper.new(themes: ["ruby", "rails"])
  ruby_rails_error = Scraper.new(themes: ["ferfzefzef"])
  python = Scraper.new(themes: ["python"])
  ruby_rails_error = Scraper.new(themes: ["ferfzefzef"])

  it "should create a scraper with keywords ruby and rails" do
    expect(ruby_rails.themes).to include("ruby", "rails")
    expect(ruby_rails.themes.length).to eq 2
  end


  context "Medium scraper " do
    before(:all) do
      @res = ruby_rails.scrape_medium
    end

    it "should return a hash" do
      expect(@res).to be_a Hash
    end
    it "should return the good search url" do
      expect(@res[:search_url]).to eq("https://www.medium.com/search?q=ruby%20rails")
    end
    it "post seach on url should return results" do
      expect_results
    end

    it "result hash should contain article url" do
      if @res[:list].present?
        expect(@res[:list].first[:url]).to be_a String
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
    it "result hash should contain a title" do
      if @res[:list].present?
        expect(@res[:list].first[:title]).to be_a String
      else
        expect_results
      end
    end
    it "result hash should contain article description" do
      if @res[:list].present?
        expect(@res[:list].first[:description]).to be_a String
      else
        expect_results
      end
    end

    it "search with no results should return a hash with error message under 'error' key" do
      expect(ruby_rails_error.scrape_medium[:list].first[:error]).to include("No results")
    end
  end

  context "tech chrunch scraper" do
    before(:all) do
      @res = python.scrape_tc
    end

    it "should return a hash" do
      expect(@res).to be_a Hash
    end
    it "should return the good search url" do
      expect(@res[:search_url]).to eq("https://techcrunch.com/search/python")
    end
    it "post seach on url should return results" do
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

    it "each @result hash should contain article image url" do
      if @res[:list].present?
        expect(@res[:list].first[:img_url]).to be_a String
        expect(@res[:list].second[:img_url]).to be_a String
        expect(@res[:list].third[:img_url]).to be_a String
      else
        expect_results
      end
    end
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

    it "search with no results should return a hash with error message under 'error' key" do
      expect(ruby_rails_error.scrape_medium[:list].first[:error]).to include("No results")
    end
  end
end
