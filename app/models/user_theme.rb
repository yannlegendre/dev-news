class UserTheme < ApplicationRecord
  belongs_to :user
  belongs_to :theme

  validates :theme, uniqueness: { scope: :user }

  def destroy
    @user_theme = UserTheme.find(params[:id])
  end
end
