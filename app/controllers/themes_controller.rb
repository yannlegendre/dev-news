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
      search_articles
      set_default_meetups
    elsif params[:search] == "Events near me"
      search_events
      set_default_articles
    elsif params[:search] == "Add to interests"
      add_interests if params[:search].present?
      set_default_articles
    end
  end

  private

  def search_articles
    s = Scraper.new(themes: params[:theme])
    ap s
    @articles = s.build_articles(s.scrape_fcc)
    set_default_meetups
  end

  def search_events
    # a = ApiCaller.new(themes: params[:theme], lon: params[:longitude], lat: params[:latitude])
    # result = a.call_eventbrite
    # @meetups = a.make_event(result)
    lat_lon = "#{params[:latitude]},#{params[:longitude]}"
    ap lat_lon
    response = Geocoder.search(lat_lon).first
    ap response.data[:city]
  end

  def add_interests
    themes = params[:theme].split(/\s+/)

    themes.each do |theme|
      Theme.create(name: theme) unless theme_instance = Theme.find_by(name: theme)
      UserTheme.find_or_create_by(theme: theme_instance, user: current_user)
    end
  end

  def set_default_articles
    @articles = Article.last(3)
  end

  def set_default_meetups
    @meetups = nil
  end
end
