class CreateClinicians < ActiveRecord::Migration
  def self.up
    create_table :clinicians do |t|
      t.string :name
      t.integer :contact_info_id

      t.timestamps
    end
  end

  def self.down
    drop_table :clinicians
  end
end
