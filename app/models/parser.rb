class Parser
  def self.last_result(url)
    i = self.new
    cache = Rails.cache.read('result')
    
#    return cache if cache
    i.fetch(url)
  end
  
  def self.journee
  	i = self.new
    cache = Rails.cache.read('journee')
    
#    return cache if cache
    i.fetchJ
  end
  
  def fetch(url)
    #@url = "http://www.ff-handball.org/competitions/seniors-masculins/championnats-nationaux/n2m/resultats.html"
    @url = url
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
    classement = []
    doc = Nokogiri::HTML(@response)
    
    doc.css('.round table tr').each do |num|
    	cls = {}
    	     
    	rang = num.search('td.num').first
    	next if not rang
    	cls['rang'] = rang.content
    	
    	el = num.search('td.eq').first
    	next if not el
    	cls['team'] = el.content
    	
    	pts = num.search('td.pts').first
    	next if not pts
    	cls['points'] = pts.content
    	
    	j = num.search('td')
    	next if not j
    	cls['journee'] = j[3].content
    	cls['gagne'] = j[4].content
    	cls['nuls'] = j[5].content
    	cls['points'] = j[6].content
    	cls['but+'] = j[7].content
    	cls['but-'] = j[8].content
    	cls['diff'] = j[9].content
    	
    	@result.push(cls)
    end   
    @result
  end
  
  def parsejournee
    @resultJ = {}
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
    	  
      #@resultJ.push(journee)
      myjournee = "journee_"+i.to_s
      @resultJ[myjournee] = journee
      i = i+1
      
    end
    
    @resultJ
  end
  
end