class CreateReferenceRanges < ActiveRecord::Migration
  def self.up
    create_table :reference_ranges do |t|
      t.integer :expert_id
      t.integer :single_test_definition_id
      t.float :reference_amount
      t.float :lower_limit
      t.float :upper_limit
    end
  end

  def self.down
    drop_table :reference_ranges
  end
end
