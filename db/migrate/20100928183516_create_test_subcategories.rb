class CreateTestSubcategories < ActiveRecord::Migration
  def self.up
    create_table :test_subcategories do |t|
      t.string :name
      t.integer :category_id
      t.integer :sequence_number
      t.timestamps
    end
  end

  def self.down
    drop_table :test_subcategories
  end
end
