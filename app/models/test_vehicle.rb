class TestVehicle < ActiveRecord::Base

  has_one :lab_report_definition
  has_one :single_test_definition

  validates_uniqueness_of :name

end
