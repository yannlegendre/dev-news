class ThemesController < ApplicationController

  def index
    @themes = current_user || Theme.all # mettre current user
  end

  def search
    if params[:search] == "Search articles"
      search_articles
    elsif params[:search] == "Search meetups"
    elsif params[:search] == "Add to interests"
    end
    render :index
  end

  def search_articles
    s = Scraper.new(themes: params[:theme])
  end
end
