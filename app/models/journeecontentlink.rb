class Journeecontentlink < ActiveRecord::Base
  attr_accessible :content_id, :journee_id
  
  belongs_to :journee
  belongs_to :content
end
