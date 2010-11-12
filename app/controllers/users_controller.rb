class UsersController < ApplicationController

  #before_filter :verify_credentials


  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
  end

  def add_user
    if not session[:logged_in] or not current_user.super_user?
      redirect_to(:action => :index)
    end
    return unless request.post?
    #if params[:password] == params[:confirm_password]
      u = User.new(:username => params[:username])
      u.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{params[:password]}--")
      u.crypted_password = u.encrypt("#{params[:password]}")
      if not u.save
        puts "user " + username + " FAILED TO ADD"
      end
      redirect_to(:action => :index)
    #else
     # flash[:notice] = "password and confirm password did not match"
    #end
  end

  def show_contact_info
    @user_id = params[:user_id]
     if params[:id] != nil
      @contact_info = ContactInfo.find(params[:id])
    else
      @contact_info = ContactInfo.new
    end
  end
  
  def update_contact_info
    if params[:id] != nil
      @contact_info = ContactInfo.find(params[:id])
    else
      @contact_info = ContactInfo.new
    end
    @contact_info.update_attributes(params[:contact_info])
    if @contact_info.save
      flash[:notice] = 'Sucessfully Updated Contact Info'
      @id = @contact_info.id
    else
      flash[:notice] = 'There was a problem saving'
    end
    redirect_to :action => 'show_contact_info', :id => @id, :user_id => params[:user_id]  
  end
  
  def remove_contact_info
    @contact_info = ContactInfo.find(params[:id])
    @contact_info.destroy
    redirect_to :action => 'show', :id => params[:user_id] 
  end
    
  def destroy
    @user = User.find(params[:id])    
    @user.destroy
    redirect_to :action => 'index'
  end

end
