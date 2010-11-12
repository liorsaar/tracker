class LabReportType < ActiveRecord::Base

  has_many :lab_report_definitions
  
end
