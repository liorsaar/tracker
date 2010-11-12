class CreateSubscriptionPlans < ActiveRecord::Migration
  def self.up
    create_table :subscription_plans do |t|
      t.string   "name"
      t.decimal  "amount",          :precision => 10, :scale => 2
      t.integer  "user_limit",      :limit => 11
      t.integer  "renewal_period",  :limit => 11, :default => 1
      t.decimal  "setup_amount",    :precision => 10, :scale => 2
      t.integer  "trial_period",    :limit => 11, :default => 1
      t.timestamps
    end
  end
  
  def self.down
    drop_table :subscription_plans
  end
end
