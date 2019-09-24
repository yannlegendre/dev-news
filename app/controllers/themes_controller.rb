class ThemesController < ApplicationController

  def index
    @themes = Theme.all # mettre current user
  end
end
