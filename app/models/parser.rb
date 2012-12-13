class Parser
  def self.last_result
    i = self.new
    cache = Rails.cache.read('result')
    
#    return cache if cache
    i.fetch
  end
  
  def self.journee
  	i = self.new
    cache = Rails.cache.read('journee')
    
#    return cache if cache
    i.fetchJ
  end
  
  def fetch
    @url = "http://www.ff-handball.org/competitions/championnats-nationaux-mf/n2m/resultats.html"
    Rails.logger.debug('=================> HTTP CALL')
    @response = HTTParty.get(@url) # BLOCKING
    #Mise en cache
    result = self.parseresult
    Rails.cache.write('result', result, :expires_in => 1.minutes) if result
    result
    
  end
  
  def fetchJ
    @url = "http://www.ff-handball.org/competitions/championnats-nationaux-mf/n2m/resultats.html"
    Rails.logger.debug('=================> HTTP CALL')
    @response = HTTParty.get(@url) # BLOCKING
    #Mise en cache
    journee = self.parsejournee
    Rails.cache.write('journee', journee, :expires_in => 1.minutes) if journee
    journee
    
  end
  
  def parseresult
    @result = []
    doc = Nokogiri::HTML(@response)
    
    doc.css('.lgClassmt table tr').each do |tr|
      result = {}
      el = tr.search('td:eq(2)').first
      next if not el
	  result['title'] = el.content
	  
	  pts = tr.search('td:eq(3)').first
	  next if not pts
	  result['points'] = pts.content
	  
	  joue = tr.search('td:eq(4)').first
	  next if not joue
	  result['joue'] = joue.content
	  
	  gagne = tr.search('td:eq(5)').first
	  next if not gagne
	  result['gagne'] = gagne.content
	  
	  nul = tr.search('td:eq(6)').first
	  next if not nul
	  result['nul'] = nul.content
	  
	  perdu = tr.search('td:eq(7)').first
	  next if not perdu
	  result['perdu'] = perdu.content
	  
	  but1 = tr.search('td:eq(8)').first
	  next if not but1
	  result['but+'] = but1.content
	  
	  but0 = tr.search('td:eq(9)').first
	  next if not but0
	  result['but-'] = but0.content
	  
	  diff = tr.search('td:eq(10)').first
	  next if not diff
	  result['diff'] = diff.content
	  
      @result.push(result)
    end    
    @result
  end
  
  def parsejournee
    @resultJ = []
    doc = Nokogiri::HTML(@response)
    Rails.logger.debug('=================> Journee')

    i = 1
    doc.css('.journee li').each do |li|
    	
    	journee = {}
    	el = li.search('.dateH').first
    	next if not el
    	journee['date'] = el.content
    	
    	score = li.search('.score strong').first
    	next if not score
    	journee['scorewin'] = score.content
    	
    	scorel = li.search('.score').first
    	next if not scorel
    	journee['score'] = scorel.content
    	
    	equipe1 = li.search('.equipe1').first
    	next if not equipe1
    	journee['equipe1'] = equipe1.content
    	
    	equipe2 = li.search('.equipe2').first
    	next if not equipe2
    	journee['equipe2'] = equipe2.content
    	  
      @resultJ.push(journee)
      i = i+1
    end
    
    @resultJ
  end
  
end