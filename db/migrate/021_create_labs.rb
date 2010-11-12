class CreateLabs < ActiveRecord::Migration
  def self.up
    create_table :labs do |t|
      t.string :name
      t.integer :contact_info_id
      t.timestamps
    end
  end

  def self.down
    drop_table :labs
  end
end
