class LabReportDefinition < ActiveRecord::Base

  belongs_to :test_vehicle
  belongs_to :lab_report_type
  belongs_to :report_provider
  
  has_many  :lab_reports

end
