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
    it "is invalid without an image" do
      expect(build(:article, img_url: nil)).to_not be_valid
    end
    it "is invalid without a url" do
      expect(build(:article, url: nil)).to_not be_valid
    end
  end

  context 'Associations' do
    it "has many comments" do
      create(:comment, commentable: @article)
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

    it "destroys its comments upon destruction" do
      article = create(:article)
      create(:comment, commentable: article)
      article.destroy
      expect(Comment.count).to eq 0
    end

    it "destroy its upvotes upon destruction" do
      article = create(:article)
      a = create(:upvote, article: article)
      article.destroy
      expect(Upvote.count).to eq 0
    end

  end

  context 'Methods' do
    it "upvoted?(user) returns true if article has been upvoted by user" do
      user = create(:user)
      article = create(:article)
      upvote = create(:upvote, user: user, article: article)
      expect(article.upvoted?(user)).to eq true
    end
    it "upvoted?(user) returns false if article is not upvoted by user" do
      user = create(:user)
      article = create(:article)
      upvote = create(:upvote, user: user, article: article)
      upvote.delete
      expect(article.upvoted?(user)).to eq false
    end

  end
end
