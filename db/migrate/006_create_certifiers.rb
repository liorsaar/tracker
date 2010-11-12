class CreateCertifiers < ActiveRecord::Migration
  def self.up
    create_table :certifiers do |t|
      t.string  :name
      t.timestamps
    end
  end

  def self.down
    drop_table :certifiers
  end
end
