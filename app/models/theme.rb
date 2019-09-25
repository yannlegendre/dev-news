class Theme < ApplicationRecord
  has_many :article_themes
  has_many :articles, through: :article_themes
  has_many :meetup_themes
  has_many :meetups, through: :meetup_themes

  validates :name, presence: true, uniqueness: true

end
