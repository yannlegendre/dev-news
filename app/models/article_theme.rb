class ArticleTheme < ApplicationRecord
  belongs_to :article
  belongs_to :theme

  validates :theme, uniqueness: { scope: :article }

end
