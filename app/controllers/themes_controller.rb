class ThemesController < ApplicationController
  def index
    @themes = Theme.all

    if params[:theme].present?
      s = Scraper.new(themes: themes)
      @articles = s.build_results
    else
      @articles = Article.last(3)
    end

  end

  def search_results
    if params[:search] == "Search articles"
      render :index, collection: new_articles
    elsif params[:search] == "Search meetups"
      render :index
    elsif params[:search] == "Add to interests"
    end
  end

end
