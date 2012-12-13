class ParserController < ApplicationController
	def index
		
	end
	
	def classement
		result = Parser.last_result
		render :json => result
	end
	
	def journee
		result = Parser.journee
		render :json => result
	end
end
