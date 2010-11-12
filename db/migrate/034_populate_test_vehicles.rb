class PopulateTestVehicles < ActiveRecord::Migration
  def self.up
    TestVehicle.create(:name => 'Blood')
    TestVehicle.create(:name => 'Hair')
    TestVehicle.create(:name => 'Urine')
  end

  def self.down
  end
end
