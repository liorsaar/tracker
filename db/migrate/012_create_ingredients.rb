class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.integer :supplement_id
      t.integer :subcomponent_id
      t.integer :sequence_number
      t.integer :quantity
      t.integer :unit_of_measure_id
      t.string  :note
      t.timestamps
    end
  end

  def self.down
    drop_table :ingredients
  end
end
