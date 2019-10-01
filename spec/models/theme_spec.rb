require 'rails_helper'

describe Theme do
  before(:each) do
    @theme = create(:theme)
  end

  context 'Validations' do
    it "has a valid factory" do
      expect(@theme).to be_valid
    end
    it "is invalid without a name" do
      expect(build(:theme, name: nil)).to_not be_valid
    end
    it "has a unique name" do
      Theme.create(name: "toto")
      expect(build(:theme, name: "toto")).to_not be_valid
    end
  end

  context 'Associations' do
    it "has many articles" do
      a1 = create(:article)
      a2 = create(:article)
      create(:article_theme, theme: @theme, article: a1)
      create(:article_theme, theme: @theme, article: a2)
      expect(@theme.articles.length).to eq 2
    end
    it "has many meetups" do
      m1 = create(:meetup)
      m2 = create(:meetup)
      create(:meetup_theme, theme: @theme, meetup: m1)
      create(:meetup_theme, theme: @theme, meetup: m2)
      expect(@theme.meetups.length).to eq 2
    end

    it "destroys instances from join tables upon destruction" do
      article = create(:article)
      meetup = create(:meetup)
      ArticleTheme.create(article: article, theme: @theme)
      MeetupTheme.create(meetup: meetup, theme: @theme)
      @theme.destroy!
      expect(ArticleTheme.count).to eq 0
      expect(MeetupTheme.count).to eq 0
    end
  end

  it "returns search results" do
    create(:theme, name: "abc def")
    create(:theme, name: "toto acoucou")
    expect(Theme.search("a").count).to eq 2
  end
end
