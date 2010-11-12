class Lab < ActiveRecord::Base

  belongs_to :contact_info
  has_one :single_test_definition
  
  validates_uniqueness_of :name
  
end
