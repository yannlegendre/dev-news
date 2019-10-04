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
    url = "https://www.eventbriteapi.com/v3/events/search?q=" + @themes.join("%20")
    result[:search_url] = url
    response = request(url)
    parsed_response = JSON.parse(response)
    result[:events] = parsed_response["events"].first(3) if parsed_response["events"].present?
    return result
  end

  def request(url)
    key =  "Bearer #{ENV['EVENTBRITE_KEY']}"
    response = RestClient.get(url, 'authorization' => key, 'Content-Type' => "application/json")
    return response.body
  end

  def make_event(result_hash)
    events = result_hash.with_indifferent_access[:events]
    events.each do |event|
      title = event[:name][:text]
      date_time = Date.parse(event[:start][:local])
      address = "Lyon"  #TODO
      url = event[:url]
      ap title
      ap date_time
      Meetup.create(title: title, address: address, date_time: date_time, url: url)
    end
  end
end
