class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string   "name"
      t.string   "full_domain"
      t.datetime "deleted_at"
      t.integer  "subscription_discount_id", :limit => 11
      t.boolean :is_active, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
