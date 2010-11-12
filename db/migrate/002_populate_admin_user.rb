class PopulateAdminUser < ActiveRecord::Migration
  def self.up
    
    u = User.new(:username => 'admin')
    u.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--IAmGod--")
    u.crypted_password = u.encrypt('IAmGod')
    if not u.save
      puts "user " + username + " FAILED TO ADD"
    end
    u = User.new(:username => 'johnk')
    u.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--knhoj--")
    u.crypted_password = u.encrypt('knhoj')
    if not u.save
      puts "user " + username + " FAILED TO ADD"
    end
    u = User.new(:username => 'jimk')
    u.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--kmij--")
    u.crypted_password = u.encrypt('kmij')
    if not u.save
      puts "user " + username + " FAILED TO ADD"
    end
    u = User.new(:username => 'brazf')
    u.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--fzarb--")
    u.crypted_password = u.encrypt('fzarb')
    if not u.save
      puts "user " + username + " FAILED TO ADD"
    end
    u = User.new(:username => 'moniquej')
    u.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--jeuqinom--")
    u.crypted_password = u.encrypt('jeuqinom')
    if not u.save
      puts "user " + username + " FAILED TO ADD"
    end
  end

  def self.down
    User.delete_all
  end
end
