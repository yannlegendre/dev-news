class ThemesController < ApplicationController
  def index
    @themes = Theme.all
    if params[:theme].present?
      launch_search
    else
      set_default_articles
      set_default_meetups
    end
  end

  def launch_search
    if params[:search] == "Search articles"
      s = Scraper.new(themes: params[:theme])
      @articles = s.build_results
      set_default_meetups
    elsif params[:search] == "Search meetups"
      ap "je suis la"
      a = ApiCaller.new(themes: params[:theme])
      result = a.call_eventbrite
      @meetups = a.make_event(result)
      set_default_articles
    elsif params[:search] == "Add to interests"
      s = Scraper.new(themes: [params[:theme]])
      @articles = s.scrape_fcc
    end
  end

  def set_default_articles
    @articles = Article.first(3)
  end
  def set_default_meetups
    @meetups = Meetup.first(3)
  end
end
