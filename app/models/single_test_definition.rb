class SingleTestDefinition < ActiveRecord::Base

  belongs_to :lab
  belongs_to :test_vehicle
  belongs_to :substance
  has_many  :reference_ranges
  has_many  :single_test_results
  belongs_to :unit_of_measure
  
end
