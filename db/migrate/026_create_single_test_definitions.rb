class CreateSingleTestDefinitions < ActiveRecord::Migration
  def self.up
    create_table :single_test_definitions do |t|
      t.integer :substance_id
      t.integer :unit_of_measure_id
      t.integer :test_vehicle_id
      t.integer :lab_id
      t.float :reference_amount # these are from the lab
      t.float :lower_limit
      t.float :upper_limit
      t.timestamps
    end
  end

  def self.down
    drop_table :single_test_definitions
  end
end
