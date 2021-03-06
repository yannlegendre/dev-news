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
    url = "https://www.eventbriteapi.com/v3/events/search?q=" + @themes.join("%20") +"&location.latitude=#{@lat}&location.longitude=#{@lon}"
    result[:search_url] = url
    ap url
    ap  "https://www.eventbriteapi.com/v3/events/search?q=java&location.latitude=45.75&location.longitude=4.85"
    response = request(url)
    # File.open("#{Rails.root}/app/services/events.json", "w") do |f|
    #   f.write(response)
    # end

    parsed_response = JSON.parse(response)
    ap response
    result[:events] = parsed_response["events"].first(3) if parsed_response["events"].present?
    return result
  end

  def simulate_call
    result = {}
    url = "https://www.eventbriteapi.com/v3/events/search?q=" + @themes.join("%20")
    result[:search_url] = url
    file = File.read("#{Rails.root}/app/services/events.json")
    events = JSON.parse(file)["events"]
    result[:events] = events.first(3) if events.present?
    return result
  end

  def request(url)
    key =  "Bearer #{ENV['EVENTBRITE_KEY']}"
    response = RestClient.get(url, 'authorization' => key, 'Content-Type' => "application/json")
    ap response.body
    return response.body
  end

  def make_event(result_hash)
    array = []
    events = result_hash.with_indifferent_access[:events]
    events.each do |event|
      title = event[:name][:text]
      date_time = Date.parse(event[:start][:local])
      url = event[:url]
      a = Meetup.create(title: title, date_time: date_time, url: url)
      array << a
    end
    return array
  end
end
