require 'rails_helper'

describe Upvote do
  before(:each) do
    @upvote = create(:upvote)
  end

  context 'Validations' do
    it "has a valid factory" do
      expect(@upvote).to be_valid
    end
    it "is invalid without a user" do
      expect(build(:upvote, user: nil)).to_not be_valid
    end
    it "is invalid without a article" do
      expect(build(:upvote, article: nil)).to_not be_valid
    end
    it "one upvote max per user and per article" do
      user = create(:user)
      article = create(:article)
      create(:upvote, user: user, article: article)
      create(:upvote, user: user, article: article)

    end
    it "several users can upvote the same article" do
      user = create(:user)
      user2 = create(:user)
      article = create(:article)
      create(:upvote, user: user, article: article)
      create(:upvote, user: user2, article: article)
    end
    it "several articles can be upvoted the same user" do
      user = create(:user)
      article = create(:article)
      article2 = create(:article)
      create(:upvote, user: user, article: article)
      create(:upvote, user: user, article: article2)
      expect(user.upvotes.count).to eq 2
    end
  end

  context 'Associations' do
    it "belongs to a user" do
      expect(@upvote.user).to be_a(User)
    end
    it "belongs_to an article" do
      expect(@upvote.article).to be_a(Article)
    end
  end
end
