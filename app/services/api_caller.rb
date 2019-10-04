class ApiCaller
  attr_accessor :themes
  attr_accessor :lon
  attr_accessor :lat
  attr_accessor :duration
  attr_accessor :radius

  def initialize(attributes = {})
    @themes = attributes[:themes].split(/\s+/)
    @lon = attributes[:lon]
    @lat = attributes[:lat]
    @duration = attributes[:duration]
    @radius = attributes[:radius]
  end

  def call_eventbrite
    result = {}
    result[:search_url] = "https://www.eventbriteapi.com/v3/events/search?q=" + @themes.join("%20")
    return result
  end

end
