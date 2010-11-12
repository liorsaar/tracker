class Customer < ActiveRecord::Base

  attr_accessible :user_id

  belongs_to  :user
  belongs_to :contact_info
  has_many  :lab_reports

end
