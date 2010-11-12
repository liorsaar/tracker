class CreateTestCategories < ActiveRecord::Migration
  def self.up
    create_table :test_categories do |t|
      t.integer :lab_report_definition_id
      t.string :name
      t.integer :sequence_number
      t.timestamps
    end
  end

  def self.down
    drop_table :test_categories
  end
end
