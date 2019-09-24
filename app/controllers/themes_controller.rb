class ThemesController < ApplicationController

  def index
    @themes = current_user || Theme.all # mettre current user
  end
end
