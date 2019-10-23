class UserTheme < ApplicationRecord
  belongs_to :user
  belongs_to :theme

  validates :theme, uniqueness: { scope: :user }
end
