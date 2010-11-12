class CreateSubscriptionDiscounts < ActiveRecord::Migration
  def self.up
    create_table :subscription_discounts do |t|
      t.string   "name"
      t.string   "code"
      t.decimal  "amount",     :precision => 6, :scale => 2, :default => 0.0
      t.boolean  "percent"
      t.date     "start_on"
      t.date     "end_on"
      t.timestamps
    end
  end

  def self.down
    drop_table :subscription_discounts
  end
end
