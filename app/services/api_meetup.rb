class Api_Meetup
  attr_accessor :themes
  attr_accessor :lon
  attr_accessor :lat
  attr_accessor :duration
  attr_accessor :radius

  def initialize(attributes = {})
    @themes = attributes[:themes]
    @lon = attributes[:lon]
    @lat = attributes[:lat]
    @duration = attributes[:duration]
    @radius = attributes[:radius]
  end

  def get_events

  end

end