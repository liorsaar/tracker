class CreatePasswordResets < ActiveRecord::Migration
  def self.up
    create_table :password_resets do |t|
      t.string   "email"
      t.integer  "user_id",    :limit => 11
      t.string   "remote_ip"
      t.string   "token"
      t.timestamps
    end
  end

  def self.down
    drop_table :password_resets
  end
end
