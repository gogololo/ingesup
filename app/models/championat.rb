class Championat < ActiveRecord::Base
  attr_accessible :name
  
  has_many :categories_championats, :class_name => 'CategoriesChampionats'
  has_many :categories, :through => :categories_championats , :source => :categorie
  
  #accepts_nested_attributes_for :categorie
end
