class CreateUserSupplements < ActiveRecord::Migration
  def self.up
    create_table :user_supplements do |t|
      t.integer :user_id
      t.integer :supplement_id
      t.integer :sequence_number
      t.integer :custom_dosage_per_day
      t.integer :is_expanded, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :user_supplements
  end
end
