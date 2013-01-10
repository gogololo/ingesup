class ParserController < ApplicationController
	def index
		@c = Categorie.all
	end
	
	def viewcat
		@search = Categorie.find(params[:catId])
		@tab = @search.resultats
		if !@tab.empty?
			@last_update = @tab[0]['created_at']
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
				i = Resultat.create(:rang => r['rang'], :team => r['team'], :points => r['points'], :journee => r['journee'], :gagne => r['gagne'], :nuls => r['nuls'], :butplus => r['but+'], :butmoins => r['but-'], :diff => r['diff'])
				
				Resultatcategorielink.create(:resultat_id => i.id, :categorie_id => catId)
			end
		end
		#render :json => result
		redirect_to :back
	end
	
	def journee
		result = Parser.journee
		render :json => result
	end
end
