class ThemesController < ApplicationController
  def index
    @themes = Theme.all
    if params[:theme].present?
      launch_search
    else
      set_default_articles
    end
  end

  def launch_search
    if params[:search] == "Search articles"
      s = Scraper.new(themes: params[:theme])
      @articles = s.build_results
      @articles.each do |article|
        ap article.themes
      end
    elsif params[:search] == "Search meetups"
      a = Api_Eventbrite.new(themes: params[:theme])
      @meetups = a.meetups
      set_default_articles
    elsif params[:search] == "Add to interests"
      # s = Scraper.new(themes: [params[:theme]])
      # @articles = s.build_results
    end
  end

  def set_default_articles
    @articles = Article.first(3)
  end
end
