class Content < ActiveRecord::Base
  attr_accessible :date, :fdm, :team1, :team1core, :team2, :team2score
  
  has_many :journeecontentlinks
  has_many :journees, :through => :journeecontentlinks
end
