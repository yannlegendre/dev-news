require 'rails_helper'

describe Article do
  before(:all) do
    @article = create(:article)
  end
  context 'Validations' do
    it "has a valid factory" do
      expect(@article).to be_valid
    end

    it "is invalid without a title" do
      expect(build(:article, title: nil)).to_not be_valid
    end
    it "is invalid without a content" do
      expect(build(:article, content: nil)).to_not be_valid
    end
    it "is invalid without a url" do
      expect(build(:article, url: nil)).to_not be_valid
    end
  end

  context 'Associations' do
    it "has many comments" do
      create(:comment_on_article, commentable: @article)
      expect(@article.comments.count).to be > 0
    end
    it "has many upvotes" do
      create(:upvote, article: @article)
      expect(@article.upvotes.count).to be > 0
    end
    it "has many themes" do
      theme = create(:theme)
      create(:article_theme, article: @article)
      expect(@article.themes.count).to be > 0
    end
  end
end
