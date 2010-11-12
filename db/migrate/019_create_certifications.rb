class CreateCertifications < ActiveRecord::Migration
  def self.up
    create_table :certifications do |t|
      t.integer :supplement_id
      t.integer :certifier_id
      t.timestamps
    end
  end

  def self.down
    drop_table :certifications
  end
end
