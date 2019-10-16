require "open-uri"
require "watir"
require 'webdrivers'
require 'headless'


class Scraper
  attr_accessor :themes

  def initialize(attributes = {})
    @themes = attributes[:themes].strip.split(/\s+/)
    @themes_str = @themes.join("%20")
  end

  def scrape_medium
    response = {}
    response[:search_url] = "https://www.medium.com/search?q=" + @themes_str
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
    # url = "https://qmjyl5wyti-dsn.algolia.net/1/indexes/news/query?x-algolia-agent=Algolia%20for%20JavaScript%20(3.33.0)%3B%20Browser&x-algolia-application-id=QMJYL5WYTI&x-algolia-api-key=4318af87aa3ce128708f1153556c6108"

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

  # convert response into array of 3 article instances saved in DB
  def build_results
    array = []
    scrape_tc[:list].each do |result|
      a = Article.find_by(title: result[:title]) || Article.create(
        title: result[:title],
        url: result[:url],
        img_url: result[:img_url],
        content: result[:description]
      )
      @themes.each do |theme|
        t = Theme.find_or_create_by(name: theme)
        # t = Theme.find_by(name: theme) || Theme.create(name: theme)
        ArticleTheme.create(article: a, theme: t)
      end
      array << a
    end
    return array
  end

end
