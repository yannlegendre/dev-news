class UserThemesController < ApplicationController

  def destroy
    @user_theme = UserTheme.find(params[:id])
    @user_theme.destroy
    redirect_to themes_path
  end

end
