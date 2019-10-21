require "open-uri"
require "watir"
require 'webdrivers'
require 'headless'


class Scraper
  attr_accessor :themes

  def initialize(attributes = {})
    @themes = attributes[:themes].split(/\s+/)
    @themes_str = @themes.join("%20")
  end

  # content is populated with JS after page is loaded so cannot be scraped efficiently with nokogiri
  # interception of the API call to algolia + borrowing api key to reproduce the request

  # this methods returns an array of 3 hashes
  def scrape_fcc
    result = []
    url = "https://qmjyl5wyti-dsn.algolia.net/1/indexes/news/query?x-algolia-agent=Algolia%20for%20JavaScript%20(3.33.0)%3B%20Browser&x-algolia-application-id=QMJYL5WYTI&x-algolia-api-key=4318af87aa3ce128708f1153556c6108"
    payload = '{"params":"query=' + @themes_str + '&hitsPerPage=15&page=0"}'
    response = JSON.parse(RestClient.post(url, payload).body)["hits"].first(3)
    response.each do |article|
      title = article["title"]
      img_url = article["featureImage"]
      url = article["url"]
      theme_array = article["tags"].map { |item| item["name"] }.first(3)
      themes = get_themes(theme_array)
      result << { title: title, img_url: img_url, url: url, themes: themes}
    end
    result
  end

  def get_themes(themes)
    res = []
    themes.each do |theme|
      res << Theme.find_or_create_by(name: theme)
    end
    return res
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
