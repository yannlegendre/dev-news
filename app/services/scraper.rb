require "open-uri"
require "watir"
require 'webdrivers'
require 'headless'


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
    node = html.search('.postArticle-content').first
    if node.present?
      title = node.search('h3').text
      img_el = node.search('.progressiveMedia-image')
      description = node.search('.graf-after--h3').text
      response[:list] << {
        url: node.at_css('a').attribute('href').value,
        img_url: img_el.present? ? img_el.attribute('src').value : "https://i-love-png.com/images/no-image_7279.png",
        title: (title.present? ? title : (node.search('.u-noWrapWithEllipsis').text || "No title")),
        description: description.present? ? description : "Click the link for more"
      }
      response[:list] << { error: "No results" } if response[:list].empty?
    else
      response[:list] << { error: "No results" }
    end
    return response
  end

  # content is populated with JS after page is loaded so cannot be scraped efficiently with nokogiri
  def scrape_fcc
    response = {}
    response[:search_url] = "https://www.freecodecamp.org/news/search/?query=" + @themes.join("%20")
    response[:list] = []
    headless = Headless.new
    headless.start
    browser = Watir::Browser.new
    browser.goto response[:search_url]
    browser.driver.save_screenshot('screenshot.png')
    html = Nokogiri::HTML.parse(browser.html)
    html.search('article').first(3).each do |node|
      # response[:list] << {
      #   url: node.at_css('a').attribute('href').value,
      #   img_url: node.at_css('.card-image-link').attribute('href').value,
      #   title: node.search('post-card-content h2 a').first.attribute('href').value,
      #   description: node.at_css('footer time').text
      # }
    end
    response[:list] << { error: "No results" } if response[:list].empty?
    # ap response
    headless.destroy
    return response
  end

  def scrape_tc
    response = {}
    response[:search_url] = "https://techcrunch.com/search/" + @themes.join("%20")
    response[:list] = []
    html = Nokogiri::HTML(open(response[:search_url]).read)
    html.search('.post-block--image').first(3).each do |node|
      content = node.at_css('.post-block__content p')
      response[:list] << {
        url: node.at_css('h2 a').attribute('href').value,
        img_url: node.at_css('footer img').attribute('src').value,
        title: node.search('h2 a').first.text.strip,
        description: content ? content.text.strip : "Click link to know more"
      }
      puts
    end
    response[:list] << { error: "No results" } if response[:list].empty?
    return response
  end

  def build_results(response)
    array = []
    response[:list].each do |result|
      a = Article.build!(
        title: result[:title],
        url: result[:url],
        img_url: result[:img_url],
        content: result[:description]
      array << a
      )
      return array
    end
  end

  def scrap_and_build
    save_results(scrape_tc)
  end
end
