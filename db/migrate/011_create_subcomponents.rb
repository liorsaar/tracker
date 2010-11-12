class CreateSubcomponents < ActiveRecord::Migration
  def self.up
    create_table :subcomponents do |t|
      t.string :name
      t.string  :note
      t.timestamps
    end
  end

  def self.down
    drop_table :subcomponents
  end
end
