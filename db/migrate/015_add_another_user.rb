class AddAnotherUser < ActiveRecord::Migration
  def self.up
    u = User.new(:username => 'Brent')
    u.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--Biz--")
    u.crypted_password = u.encrypt('Biz')
    if not u.save
      puts "user " + username + " FAILED TO ADD"
    end
  end

  def self.down
  end
end
