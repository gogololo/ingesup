module ApplicationHelper
	def syntaxhighlighter(html)
	
	    doc = Nokogiri::HTML(html)
	
	    doc.search("//pre[@lang]").each do |pre|
	
	      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
	
	    end
	
	    doc.tos
	
	  end
end
