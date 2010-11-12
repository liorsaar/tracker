class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.decimal  "amount",                :precision => 10, :scale => 2
      t.datetime "next_renewal_at"
      t.string   "card_number"
      t.string   "card_expiration"
      t.string   "state",                 :default => "trial"
      t.integer  "subscription_plan_id",  :limit => 11
      t.integer  "account_id",            :limit => 11
      t.integer  "user_limit",            :limit => 11
      t.integer  "renewal_period",        :limit => 11, :default => 1
      t.string   "billing_id"
      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
