class Upvote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :article, uniqueness: { scope: :user }
end
