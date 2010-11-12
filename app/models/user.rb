class User < ActiveRecord::Base

  belongs_to :account
  has_many :customers

  alias_attribute :display_name, :username

  def self.authenticate(username, password)    
    u = find_by_username(username)
    if u != nil and u.authenticated?(password)
      u.save
      result = u
    else
      result = nil
    end
    return result
  end

  # Check if the encrypted passwords match
  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end
  
  def self.encrypt(password, salt)
     Digest::SHA1.hexdigest("--#{salt}--#{password}--")
   end

  # Expire the login token, resulting in a forced login next time.
  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  # --- Hobo Permissions --- #

  def super_user?
    username == 'admin' or username == 'admin2' 
  end

  def creatable_by?(creator)
    creator.guest?
  end

  def updatable_by?(updater, new)
    updater = self
  end

  def deletable_by?(deleter)
    deleter == self
  end

  def viewable_by?(viewer, field)
    true
  end


  # --- Fallback permissions --- #

  # (Hobo checks these for models that do not define the *_by? methods)

  def can_create?(obj)
    false
  end

  def can_update?(obj, new)
    false
  end

  def can_delete?(obj)
    false
  end

  def can_view?(obj, field)
    true
  end

  def guest?
    false
  end

end
