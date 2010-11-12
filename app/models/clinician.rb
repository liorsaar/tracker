class Clinician < ActiveRecord::Base

  has_many  :lab_reports

  validates_uniqueness_of :name

end
