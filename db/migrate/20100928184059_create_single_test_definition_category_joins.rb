class CreateSingleTestDefinitionCategoryJoins < ActiveRecord::Migration
  def self.up
    create_table :single_test_definition_category_joins do |t|
      t.integer :category_or_subcategory_id
      t.integer :single_test_definition_id
      t.timestamps
    end
  end

  def self.down
    drop_table :single_test_definition_category_joins
  end
end
