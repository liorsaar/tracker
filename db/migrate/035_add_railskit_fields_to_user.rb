class AddRailskitFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column  :users, "email", :string
    add_column  :users, "activation_code", :string
    add_column  :users, "account_id", :integer
    add_column  :users, "is_active", :boolean
  end

  def self.down
    remove_column  :users, "email"
    remove_column  :users, "activation_code"
    remove_column  :users, "account_id"
    remove_column  :users, "is_active"
  end
end
