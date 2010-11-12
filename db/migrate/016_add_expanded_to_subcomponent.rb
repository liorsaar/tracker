class AddExpandedToSubcomponent < ActiveRecord::Migration
  def self.up
    add_column  :subcomponents, "expanded", :integer, :default => 0
  end

  def self.down
    remove_column  :subcomponents, "expanded"
  end
end
