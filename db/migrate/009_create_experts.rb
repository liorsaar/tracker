class CreateExperts < ActiveRecord::Migration
  def self.up
    create_table :experts do |t|
      t.string  :name
      t.timestamps
    end
  end

  def self.down
    drop_table :experts
  end
end
