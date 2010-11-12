class Expert < ActiveRecord::Base

  validates_uniqueness_of :name
  has_one  :reference_range

end
