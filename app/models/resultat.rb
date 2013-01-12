class Resultat < ActiveRecord::Base
  attr_accessible :butplus, :butmoins, :diff, :gagne, :journee, :nuls, :points, :rang, :team, :perdu
  
  has_many :resultatcategorielinks
  has_many :categories, :through => :resultatcategorielinks
end
