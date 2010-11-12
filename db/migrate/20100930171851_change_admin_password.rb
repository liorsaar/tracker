class ChangeAdminPassword < ActiveRecord::Migration
  def self.up
    u = User.find_by_username('admin')
    u.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--scrum--")
    u.crypted_password = u.encrypt('scrum')
    if not u.save
      puts "user " + username + " FAILED TO ADD"
    end
  end

  def self.down
  end
end
