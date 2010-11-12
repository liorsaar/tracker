class ReferenceRange < ActiveRecord::Base

  belongs_to  :single_test_definition
  belongs_to :expert

end
