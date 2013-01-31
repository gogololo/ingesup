class Categorie < ActiveRecord::Base
  attr_accessible :name, :url
  
  has_many :resultatcategorielinks
  has_many :resultats, :through => :resultatcategorielinks
  
  has_many :journeecategorielinks
  has_many :journees, :through => :journeecategorielinks
  
  has_many :categories_championats, :class_name => 'CategoriesChampionats'
  has_many :championats, :through => :categories_championats, :source => :championat
end
