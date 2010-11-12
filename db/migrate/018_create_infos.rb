class CreateInfos < ActiveRecord::Migration
  def self.up
    create_table :infos do |t|
      t.integer :supplement_id
      t.integer :number_of_paragraphs
      t.string  :paragraph1
      t.string  :paragraph2
      t.string  :paragraph3
      t.string  :paragraph4
      t.timestamps
    end
  end

  def self.down
    drop_table :infos
  end
end
