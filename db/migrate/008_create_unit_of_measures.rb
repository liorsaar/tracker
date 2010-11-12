class CreateUnitOfMeasures < ActiveRecord::Migration
  def self.up
    create_table :unit_of_measures do |t|
      t.string  :name
      t.timestamps
    end
  end

  def self.down
    drop_table :unit_of_measures
  end
end
