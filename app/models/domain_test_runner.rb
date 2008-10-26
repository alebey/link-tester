require 'mechanize'
require 'hpricot'
class DomainTestRunner
  def self.run!(url,measurement)
    domain = Domain.find(1)
    adresses = domain.adresses
    test = self.new(url,measurement)
    test.test_url!(adresses)
  end
  def initialize(url,measurement="default")
    @url = url
    @mesurement = measurement
    @agent = WWW::Mechanize.new
    @agent.user_agent_alias = "Windows IE 6"
  end

  def test_url!(adresses)
    adresses.each do |adress|
     resp = @agent.get("#{@url}#{adress.path}")
     persist_response(resp,adress)
    end
  end
  
  def persist_response(page,adress)
    doc = Hpricot(page.body)
    response = page.response
    test = TestResult.new
    test.adress = adress
    test.title = (doc/"/title").inner_html
    test.description = (doc/"/description").inner_html
    test.measurement = @measurement
    test.response_code = response["status"]
    test.test_path = response["set-cookie"]
    test.cache_control = response["cache-control"] 
    test.content_type = response["content-type"]
    test.date = response["date"]
    test.server = response["server"]
    test.response_time = response["x-runtime"]
    test.response_size = response["content-length"]
    test.save!
  end
end