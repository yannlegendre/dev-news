class ThemesController < ApplicationController
  def index
    @user_themes = current_user.user_themes.limit(6).order("RANDOM()")
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
    render :index
  end

  private

  def search_articles
    s = Scraper.new(themes: params[:theme])
    @articles = s.build_articles(s.scrape_fcc)
    set_default_meetups
  end

  def search_events
    # a = ApiCaller.new(themes: params[:theme], lon: params[:longitude], lat: params[:latitude])
    # result = a.call_eventbrite
    # @meetups = a.make_event(result)
    lat_lon = "#{params[:latitude]},#{params[:longitude]}"
    response = Geocoder.search(lat_lon).first
    @geoloc = true
    @theme = "'#{params[:theme].split(/\s+/).join(' ')}'"
    @city = response.data["address"]["city"]
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
