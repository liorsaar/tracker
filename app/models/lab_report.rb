class LabReport < ActiveRecord::Base

  belongs_to  :lab_report_definition
  belongs_to :customer
  belongs_to :clinician
  belongs_to :lab_clinician
  has_many  :single_test_results

end
