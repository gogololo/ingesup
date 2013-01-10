class Categorie < ActiveRecord::Base
  attr_accessible :name, :url
  
  has_many :resultatcategorielinks
  has_many :resultats, :through => :resultatcategorielinks
  
  has_many :journeecategorielinks
  has_many :journees, :through => :journeecategorielinks
end
