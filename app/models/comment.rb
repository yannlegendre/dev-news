class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates :content, :commentable_type, presence: true

  def article
    commentable_type == 'Article' ? commentable : nil
  end

  def all_comments
    comments
  end

end
