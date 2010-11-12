class CreateSubscriptionPayments < ActiveRecord::Migration
  def self.up
    create_table :subscription_payments do |t|
      t.integer  "account_id",      :limit => 11
      t.integer  "subscription_id", :limit => 11
      t.decimal  "amount",                        :precision => 10, :scale => 2, :default => 0.0
      t.string   "transaction_id"
      t.boolean  "setup"
      t.timestamps
    end
  end

  def self.down
    drop_table :subscription_payments
  end
end
