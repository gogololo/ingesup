class Parser
  def self.last_result(url)
    i = self.new
    cache = Rails.cache.read('result')
    
#    return cache if cache
    i.fetch(url)
  end
  
  def self.journee(url)
  	i = self.new
    cache = Rails.cache.read('journee')
    
#    return cache if cache
    i.fetchJ(url)
  end
  
  
  
  def fetchJ(url)
    @url = url
    Rails.logger.debug('=================> HTTP CALL')
    @response = HTTParty.get(@url) # BLOCKING
    #Mise en cache
    journee = self.parsejournee
    Rails.cache.write('journee', journee, :expires_in => 1.minutes) if journee
    journee
    
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
    	
    	j = num.search('td')
    	next if not j
    	cls['points'] = j[2].content
    	cls['journee'] = j[3].content
    	cls['gagne'] = j[4].content
    	cls['nuls'] = j[5].content
    	cls['perdu'] = j[6].content
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
    doc.css('#journeelist').each do |li|
    	
    	journee = {}
    	
    	el = li.search('li')
    	list_j = []
    	el.each do |l|
    		list = {}
    		# Recuperation de la class de la journee
    		class_j = l['class']
    		class_split = class_j.split(' ')
    		tab = li.search('.'+class_split[0]).first
    		
    		# Recuperation des titres
    		titre = tab.search('.titreJour')
    		next if not titre
    		list['titre'] = titre.text
    		
    		table = tab.search('table')
    		content_j = []
    		table.each do |tb|
    			j = {}
    			# Recuperation de la date du match
    			date = tb.search('td.date')
    			next if not date
    			d = date.text
    			j['date'] = d
    			
    			#Recuperation des equipes du match
    			teams = tb.search ('td.eq p')
    			next if not teams
    			eq1 = teams[0].text
    			eq1_split = eq1.split(' ', 2)
    			j['team1'] = eq1_split[1]
    			j['team1_score'] = eq1_split[0]
    			
    			eq2 = teams[1].text
    			eq2_split = eq2.split(' ', 2)
    			j['team2'] = eq2_split[1]
    			j['team2_score'] = eq2_split[0]
    			
    			#Recuperation de la feuille de match
    			fdm = tb.search('td.fdm a').first
    			next if not fdm
    			href = fdm['href']
    			j['fdm'] = 'http://www.ff-handball.org'+href
    			
    			content_j.push(j)
    		end
    		list['content'] = content_j
    		list_j.push(list)
    	end
    	journee = list_j
    	
      #@resultJ.push(journee)
      @resultJ['journee'] = journee
      i = i+1
      
    end
    
    @resultJ
  end
  
end