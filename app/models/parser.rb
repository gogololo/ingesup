class Parser
  def self.last_result
    i = self.new
    cache = Rails.cache.read('result')
    
#    return cache if cache
    i.fetch
  end
  
  def fetch
    @url = "http://www.ff-handball.org/competitions/championnats-nationaux-mf/n2m/resultats.html"
    Rails.logger.debug('=================> HTTP CALL')
    @response = HTTParty.get(@url) # BLOCKING
    #Mise en cache
    result = self.parse
    Rails.cache.write('result', result, :expires_in => 1.minutes) if result
    result
    
  end
  
  def parse
    @result = []
    doc = Nokogiri::HTML(@response)
    
    doc.css('.lgClassmt table tr').each do |tr|
      result = {}
      el = tr.search('td:eq(2)').first
      next if not el
	  
	  result['title'] = el.content
      @result.push(result)
    end
    
#    doc.xpath(".//*[@id='c6221']/div[3]/table/tbody/tr[2]/td[2]").each do |link|
#    	result = {}
#    	result['title'] = link.content
#    	@result.push(result)
#    end
    
    @result
  end
end