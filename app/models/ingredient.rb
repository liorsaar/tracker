class Ingredient < ActiveRecord::Base

  belongs_to  :supplement
  belongs_to  :subcomponent  
  
end
