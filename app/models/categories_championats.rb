class CategoriesChampionats < ActiveRecord::Base
  attr_accessible :categorie_id, :championat_id
  
  belongs_to :championat
  belongs_to :categorie
end
