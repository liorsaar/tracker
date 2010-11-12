class CreateContactInfos < ActiveRecord::Migration
  def self.up
    create_table :contact_infos do |t|
      t.string :phone
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_infos
  end
end
