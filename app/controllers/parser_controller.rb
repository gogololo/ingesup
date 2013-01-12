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
		end
		
		@j = @search.journees
		
		result = {}
		result['classement'] = @tab
		
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
		redirect_to :back
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
			result['journee'].each do |j|
				journee = Journee.create(:title => j['titre'])
				
				Journeecategorielink.create(:journee_id => journee.id, :categorie_id => catId)
				
				j['content'].each do |c|
					content = Content.create(:date => c['date'], :team1 => c['team1'], :team1core => c['team1_score'], :team2 => c['team2'], :team2score => c['team2_score'], :fdm => c['fdm'])
					
					Journeecontentlink.create(:content_id => content.id, :journee_id => journee.id)
				end
			end
		end
		
		#render :json => result
		redirect_to :back
	end
end
