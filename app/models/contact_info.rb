class ContactInfo < ActiveRecord::Base
  has_one :lab
  has_one :customer
end
