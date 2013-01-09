class Resultatcategorielink < ActiveRecord::Base
  attr_accessible :categorie_id, :resultat_id
  
  belongs_to :resultat
  belongs_to :categorie
end
