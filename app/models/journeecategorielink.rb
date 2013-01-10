class Journeecategorielink < ActiveRecord::Base
  attr_accessible :categorie_id, :journee_id
  
  belongs_to :journee
  belongs_to :categorie
end
