class AddRetestIntervalToSingleTestDefinitions < ActiveRecord::Migration
  def self.up
    add_column  :single_test_definitions, "retest_interval", :integer, :default => 12
  end

  def self.down
    remove_column  :single_test_definitions, "retest_interval"
  end
end
