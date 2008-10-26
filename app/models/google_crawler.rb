require 'mechanize'
require 'hpricot'
class GoogleCrawler
  def self.crawl!(site,start=0,limit=1000)
    g = self.new(site)
    g.search_google(start,limit)
  end
  def initialize(site)
    @site = site
  end
  def search_google(start=0,limit=1000)
    page_uri="http://www.google.de/search?hl=de&q=site%3A#{@site}&start=#{start}"
    domain = Domain.find_or_create_by_url(@site)
    agent = WWW::Mechanize.new
    agent.user_agent_alias = "Windows IE 6"
    return parse_google_page(agent,page_uri,domain,limit)
  end
    def parse_google_page(agent,page_uri,domain,limit=500)
    page = agent.get(page_uri)
    doc = Hpricot(page.body)
    (doc/"li.g").each do |google_element|
      headline = google_element.at("a.l")
      url = headline.attributes['href']
      if adress = Adress.find_by_uri(url)
      #
      else
        adress = Adress.new
      end
      adress.uri = url
      splitted_uri = url.match(/(http:\/\/[^\/]*)(.*)/)
      adress.title = headline.inner_html
      adress.path = splitted_uri[2]
      adress.domain = domain
      adress.description = google_element.at("div.s").inner_html.to_s
      adress.crawled_at = Time.now
      adress.save!
    end
    next_page = (doc/"table#nav//td").last
    page_start = page_uri.match(/start=([0-9]*)/)[1].to_i + 10
    if next_page.inner_html.match("Vorwärts") && page_start < limit
       parse_google_page(agent,"http://www.google.de"+next_page.at("/a")["href"],domain,limit)
    else
      return true
    end
  end
end