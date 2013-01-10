class Journee < ActiveRecord::Base
  attr_accessible :title
  
  has_many :journeecategorielinks
  has_many :journeecontentlinks
  has_many :categories, :through => :journeecategorielinks
  has_many :contents, :through => :journeecontentlinks
end
