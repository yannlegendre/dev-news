class Article < ApplicationRecord
  has_many :upvotes, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :article_themes, dependent: :destroy
  has_many :themes, through: :article_themes

  validates :title, :url, :content, presence: true

  def upvoted?(user)
    upvotes.where(user: user).any?
  end


  # def all_comments
  #   all_descending_comments(self)
  # end

  # private

  # def all_descending_comments(a_comment)
  #   arr = []
  #   return [] if a_comment.comments.empty?

  #   a_comment.comments.each do |current_comment|
  #     arr << current_comment
  #     all_descending_comments(current_comment) if current_comment.comments.any?
  #   end

  #   return arr
  # end

end
