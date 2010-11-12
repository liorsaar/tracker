class UnitOfMeasure < ActiveRecord::Base

  has_one :single_test_definition
  validates_uniqueness_of :name

end
