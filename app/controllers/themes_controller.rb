class ThemesController < ApplicationController

  def index
    @themes = Theme.all
    @articles = Article.first(3)
  end

  def search
    if params[:search] == "Search articles"
      render :index, locals: { @articles: search_articles }
    elsif params[:search] == "Search meetups"
      render :index
    elsif params[:search] == "Add to interests"
    end
  end

  def search_articles
    if params[:themes].present?
      themes = params[:themes]
    else
      themes = ["javascript"]
    end
    s = Scraper.new(themes: themes)
    return s.build.results
  end
end
