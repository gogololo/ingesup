class Categorie < ActiveRecord::Base
  attr_accessible :name, :url
  
  has_many :resultatcategorielinks
  has_many :resultats, :through => :resultatcategorielinks
end
