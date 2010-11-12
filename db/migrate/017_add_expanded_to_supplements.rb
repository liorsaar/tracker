class AddExpandedToSupplements < ActiveRecord::Migration
  def self.up
    add_column  :supplements, "expanded", :integer, :default => 0
  end

  def self.down
    remove_column  :supplements, "expanded"
  end
end
