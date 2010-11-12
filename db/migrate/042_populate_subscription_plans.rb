class PopulateSubscriptionPlans < ActiveRecord::Migration
  def self.up
    puts "Creating Subscription Plans..."
    SubscriptionPlan.create(
      { 'name' => 'monthly',
        'amount' => 4,
        'user_limit' => nil,
        'renewal_period' => 1 })
    SubscriptionPlan.create(
      { 'name' => 'annual',
        'amount' => 30,
        'renewal_period' => 12,
        'user_limit' => nil })

  end

  def self.down
  end
end
