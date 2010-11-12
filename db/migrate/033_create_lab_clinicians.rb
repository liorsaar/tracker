class CreateLabClinicians < ActiveRecord::Migration
  def self.up
    create_table :lab_clinicians do |t|
      t.string :name
      t.integer :contact_info_id
 
      t.timestamps
    end
  end

  def self.down
    drop_table :lab_clinicians
  end
end
