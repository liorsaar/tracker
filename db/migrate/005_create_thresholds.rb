class CreateThresholds < ActiveRecord::Migration
  def self.up
    create_table :thresholds do |t|
      t.integer :expert_id
      t.integer :subcomponent_id
      t.integer :unit_of_measure_id
      t.integer :recommended_amount
      t.integer :lower_limit
      t.integer :upper_limit
      t.timestamps
    end
  end

  def self.down
    drop_table :thresholds
  end
end
