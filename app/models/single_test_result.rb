class SingleTestResult < ActiveRecord::Base

  belongs_to  :single_test_definition
  belongs_to  :lab_report

end
