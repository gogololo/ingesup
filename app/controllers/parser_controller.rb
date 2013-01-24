class ParserController < ApplicationController
	
	before_filter :authenticate, :except => [:index, :viewcat]
	
	def index
		@c = Categorie.all
	end
	
	def viewcat
		@search = Categorie.find(params[:catId])
		@tab = @search.resultats
		if !@tab.empty?
			@last_update = @tab[0]['created_at']
			
			dd = @last_update + 2.day
			today = Time.now
			
			if today > dd
				self.classement
			end
		else
			self.classement
		end
		
		@j = @search.journees
		if !@j.empty?
			@last_update_j = @j[0]['created_at']
			
			dd = @last_update_j + 2.day
			today = Time.now
			
			if today > dd
				self.journee
				
			end
		else
			self.journee
		end
		
		@search = Categorie.find(params[:catId])
		@tab = @search.resultats
		@j = @search.journees
		
		jour = []
		i = 1
		@j.each do |j|
			jo = {}
			#jo['titre'] = j['title']
			find = Journee.find(j['id'])
			find_content = find.contents
			content = []
			find_content.each do |f|
				c = {}
				c['team1'] = f['team1']
				c['team2'] = f['team2']
				c['team1score'] = f['team1core']
				c['team2score'] = f['team2score']
				c['date'] = f['date']
				c['fdm'] = f['fdm']
				
				content.push(c)
			end
			name_j = 'journee_'+i.to_s
			jo[name_j] = content
			i = i + 1
			
			jour.push(jo)
		end
		
		result = {}
		result['classement'] = @tab
		result['journee'] = jour
		
		
		respond_to do |format|
			format.html # show.html.erb
			format.json  { render :json => result }
		end
	end
	
	def create
		@cat = Categorie.new(params[:categorie])
		
		respond_to do |format|
			if @cat.save
				format.html { redirect_to :back }
				format.json { render :json => @cat , :status => :created }
			else
				format.json { render :json => @cat.errors , :status => :unprocessable_entity }
			end
		end
	end
	
	def classement
		catId = params[:catId]
		search = Categorie.find(catId)
		url = search.url
		result = Parser.last_result(url)
		
		if !result.empty?
			# Destruction des anciens resultats
			res = search.resultats
			res.each do |re|
				re.destroy
			end
			
			# Ecriture en BDD des nouveaux resultats issu tu parser
			result.each do |r|
				i = Resultat.create(:rang => r['rang'], :team => r['team'], :points => r['points'], :journee => r['journee'], :gagne => r['gagne'], :nuls => r['nuls'], :butplus => r['but+'], :butmoins => r['but-'], :diff => r['diff'], :perdu => r['perdu'])
				
				Resultatcategorielink.create(:resultat_id => i.id, :categorie_id => catId)
			end
		end
		#render :json => result
		#redirect_to :back
	end
	
	def journee
		catId = params[:catId]
		search = Categorie.find(catId)
		url = search.url
		result = Parser.journee(url)
		
		if !result.empty?
			# Destruction des anciennes journees
			search_j = search.journees
			search_j.each do |sj|
				sj.destroy
			end
			
			# Ecriture en BDD des nouvelles journees issu tu parser
			result['journee'].each do |jj|
				journee = Journee.create(:title => jj['titre'])
				
				Journeecategorielink.create(:journee_id => journee.id, :categorie_id => catId)
				
				jj['content'].each do |c|
					content = Content.create(:date => c['date'], :team1 => c['team1'], :team1core => c['team1_score'], :team2 => c['team2'], :team2score => c['team2_score'], :fdm => c['fdm'])
					
					Journeecontentlink.create(:content_id => content.id, :journee_id => journee.id)
				end
			end
		end
		
		#render :json => result
		#redirect_to :back
	end
end
