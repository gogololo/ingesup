class AdminController < ApplicationController
  
  before_filter :authenticate
  
  def index
  end
  
  def championat
  
  end
  
  def createchampionat
  	@champ = Championat.new(params[:championat])
  	
  	respond_to do |format|
  		if @champ.save
  			format.html { redirect_to :back }
  			format.json { render :json => @cat , :status => :created }
  		else
  			format.json { render :json => @cat.errors , :status => :unprocessable_entity }
  		end
  	end
  end
end
