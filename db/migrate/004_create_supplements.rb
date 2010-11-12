class CreateSupplements < ActiveRecord::Migration
  def self.up
    create_table :supplements do |t|
      t.string  :brand_name
      t.integer :capsules_per_bottle
      t.integer :dosage
      t.integer :doses_per_day
      t.integer :take_with_food
      t.string  :bar_code
      t.string  :product_code
      t.integer :certifier_id # no longer user, this would only allow one certifier per supplement
      t.string  :note
      t.timestamps
    end
  end

  def self.down
    drop_table :supplements
  end
end
