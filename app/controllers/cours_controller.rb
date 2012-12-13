require 'nokogiri'
require 'open-uri'

class CoursController < ApplicationController
	def index
	
	end
	
	def view
		  
	end
	
	def parser
		@content = []
		doc = Nokogiri::HTML(open("http://floiraccenonhb.fr"))
		doc.xpath('//p').each do |node|
		  @content.push node.text
		end
		
	end
	
	def ffhb
		result = Parser.journee
		render :json => result
	end
end
