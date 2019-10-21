require 'rails_helper'

describe Scraper do
  good_search = Scraper.new(themes: "ruby rails")
  no_result_search = Scraper.new(themes: "ferfzefzef")

  it "should create a test scraper with keywords ruby and rails" do
    expect(good_search.themes).to include("ruby", "rails")
    expect(good_search.themes.length).to eq 2
  end
  it "should create a test scraper with garbage keywords" do
    expect(no_result_search.themes).to include("ferfzefzef")
  end

  context "Free code camp scraper" do
    before(:all) do
      @res = good_search.scrape_fcc
    end

    it "should return an array " do
      expect(@res).to be_a Array
    end

    it "should return 3 results" do
      expect(@res.length).to eq 3
    end

    it "each result hash should contain article url" do
      expect(@res.first[:url]).to be_a String
      expect(@res.second[:url]).to be_a String
      expect(@res.third[:url]).to be_a String
    end

    it "each result hash should contain article image url" do
      expect(@res.first[:img_url]).to be_a String
      expect(@res.second[:img_url]).to be_a String
      expect(@res.third[:img_url]).to be_a String
    end
    it "each result hash should contain a title" do
      expect(@res.first[:title]).to be_a String
      expect(@res.second[:title]).to be_a String
      expect(@res.third[:title]).to be_a String
    end
    it "each result hash should contain a list of themes instances" do
      expect(@res.first[:themes]).to be_a Array
      expect(@res.second[:themes]).to be_a Array
      expect(@res.third[:themes]).to be_a Array
    end

    it "search with no results should return an empty array" do
      expect(no_result_search.scrape_fcc).to eq []
    end
  end

  context "get themes method" do
    it "should return an array of themes instances" do
      t = good_search.get_themes(["ruby", "rails"])
      expect(t).to be_a Array
      expect(t.first).to be_a Theme
    end


    it "should create new themes if the one just scrapped did not exist" do
      r = Theme.create(name: "ruby")
      t = good_search.get_themes(["rails", "ruby"])
      expect(t.length).to eq 2
      expect(Theme.last.name).to eq "rails"
    end

    it "should find existing themes in database" do
      r = Theme.create(name: "ruby")
      t = good_search.get_themes(["ruby"])
      expect(t.length).to eq 1
      expect(Theme.last.name).to eq "ruby"
    end
  end

  context "build articles" do
    before(:all) do
      themes = [create(:theme), create(:theme), create(:theme)]
      @res = good_search.build_articles([title: "coucou", url: "toto", img_url: "toto", themes: themes])
    end

    it "should return an array of instances of Article" do
      expect(@res).to be_an Array
      expect(@res.first).to be_a Article
    end
    it "should find a given article based on existing title" do
      create(:article, title: "coucou")
      themes = [create(:theme), create(:theme), create(:theme)]
      good_search.build_articles([title: "coucou", url: "toto", img_url: "toto", themes: themes])
      ap Article.all
      expect(Article.all.length).to eq 2
    end

    it "should create a new article if title does not exist in db" do
      create(:article)
      expect(Article.all.length).to eq 2
    end
  end
end
