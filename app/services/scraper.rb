require "open-uri"

class Scraper
  attr_accessor :themes

  def initialize(attributes = {})
    @themes = attributes[:themes]
  end

  def scrape_medium
    response = {}
    response[:search_url] = "https://www.medium.com/search?q=" + @themes.join("%20")
    response[:list] = []
    html = Nokogiri::HTML(open(response[:search_url]).read)
    html.search('.postArticle-content').first(3).each do |node|
      title = node.search('h3').text
      description = node.search('.graf-after--h3').text
      response[:list] << {
        url: node.at_css('a').attribute('href').value,
        # img_url: 0,
        title: (title.present? ? title : (node.search('.u-noWrapWithEllipsis').text || "No title")),
        description: description.present? ? description : "Click the link for more"
      }
    end
    ap response
    return response
  end
end
