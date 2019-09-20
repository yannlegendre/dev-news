require 'rails_helper'

describe Comment do
  before(:each) do
    @comment_on_article = create(:comment_on_article)
    @reply = create(:reply)
  end

  context 'Validations' do
    it "has a valid factory" do
      expect(@comment_on_article).to be_valid
      expect(@reply).to be_valid
    end
    it "is invalid without a content" do
      expect(build(:comment_on_article, content: nil)).to_not be_valid
      expect(build(:reply, content: nil)).to_not be_valid
    end
    it "is invalid without a commentable_type" do
      expect(build(:comment_on_article, commentable_type: nil)).to_not be_valid
      expect(build(:reply, commentable_type: nil)).to_not be_valid
    end
    it "is invalid without a commentable" do
      expect(build(:comment_on_article, commentable: nil)).to_not be_valid
      expect(build(:reply, commentable: nil)).to_not be_valid
    end
    it "commentable_type is comment if comment is on a comment" do
      expect(@reply.commentable_type).to eq("Comment")
    end
    it "commentable_type is article if comment is on a article" do
      expect(@comment_on_article.commentable_type).to eq("Article")
    end
  end

  context 'Associations' do
    it "has many comments" do
      create(:reply, commentable: @comment_on_article)
      create(:reply, commentable: @reply)
      expect(@comment_on_article.comments.count).to be > 0
      expect(@reply.comments.count).to be > 0
    end
    it "belongs to a user" do
      expect(@comment_on_article.user).to be_a(User)
      expect(@reply.user).to be_a(User)
    end
    it "belongs_to an article or a comment" do
      expect(@comment_on_article.commentable).to be_a(Article)
      expect(@reply.commentable).to be_a(Comment)
    end
  end

  context 'Methods' do
    it ".article should work if direct commentable is the article" do
      expect(@comment_on_article.article).to eq(@comment_on_article.commentable)
      expect(@reply.article).to be_nil
    end
    # it '.all_comments should output the whole flattened hierarchy of descending comments' do
    #   art = create(:article)
    #   first_com = create(:comment_on_article, commentable: art)
    #   nested_com = create(:reply, commentable: first_com)
    #   second_nested_com = create(:reply, commentable: nested_com)
    #   ap art.all_comments
    #   expect(art.all_comments.count).to eq 3
    # end
  end
end
