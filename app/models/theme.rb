class Theme < ApplicationRecord
  has_many :article_themes, dependent: :destroy
  has_many :articles, through: :article_themes
  has_many :meetup_themes, dependent: :destroy
  has_many :meetups, through: :meetup_themes

  validates :name, presence: true, uniqueness: true

  include PgSearch::Model
  pg_search_scope :search, against: :name, using: {
    tsearch: { prefix: true }
  }
end
