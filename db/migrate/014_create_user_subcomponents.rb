class CreateUserSubcomponents < ActiveRecord::Migration
  def self.up
    create_table :user_subcomponents do |t|
      t.integer :user_id
      t.integer :subcomponent_id
      t.integer :unit_of_measure_id
      t.integer :total
      t.integer :percent_out
      t.integer :sequence_number
      t.timestamps
    end
  end

  def self.down
    drop_table :user_subcomponents
  end
end
