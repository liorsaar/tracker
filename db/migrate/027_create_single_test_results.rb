class CreateSingleTestResults < ActiveRecord::Migration
  def self.up
    create_table :single_test_results do |t|
      t.integer :single_test_definition_id
      t.integer :lab_report_id
      t.float :result_amount

      t.timestamps
    end
  end

  def self.down
    drop_table :single_test_results
  end
end
