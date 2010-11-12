#require "lib/MemoryProfiler"
require 'lib/authenticated_system'
class FrontController < ApplicationController

  def initialize_session
    if not session[:initialized]
      session[:permissions] = [false, false, false, false, false, false, false, false, false, false]
      session[:ui_state] = UiState.new
      
      #session[:current_user] = User.find(:first, :conditions => ["username = 'guest'"])
      session[:current_user] = Guest.new
      puts "current user is " + session[:current_user].display_name
      session[:timer_enabled] = false
      session[:initialized] = true
      session[:logged_in] = false
      #MemoryProfiler.start # singleton

      puts "session initialized"
    else
      puts "session ALREADY initialized"
      puts "clearing UI State"
      session[:ui_state].reset
    end
  end

  def index
    if true #session[:logged_in]
      redirect_to(:controller => 'supplements')
    else
      session[:page] = "index"
      @supplements = Supplement.find(:all)
    end
  end

  def reset_page
    session[:timer_enabled] = false  
    session[:initialized] = false
  end

  def old_index
    if session[:logged_in]
      redirect_to(:action => 'product_menu')
    else
      #reset_session # ??? FOR DEVELOPMENT ONLY
      reset_page
      initialize_session
      @products = Product.find(:all, :order => 'part_number ASC')
      session[:page] = "index"
     # puts "before " + cookies[:test_on].to_s
      if cookies[:test_on].to_s.blank? and session[:cookie_test] != "true"
        cookies[:test_on] = "on"
        session[:cookie_test] = "true"
        redirect_to(:action => 'index')
      end
    end
    # puts "after " + cookies[:test_on].to_s
  end

  def contact_us
  
  end
  
# Hobo actions

  def search
  end

  def do_search
    searched_name  = '%'+params[:query]+'%'

    @users = User.find(:all, :conditions => ['username LIKE ?', searched_name])
    render :update do | page |
      if @users.length > 0 
        page.replace_html 'search_results', :partial => 'search_partial'
      else
        page.replace_html 'search_results', "<p>Your search returned no matches.</p>"
      end
    end
  end

  def login   
    puts "login"
    return unless request.post?
    puts "is post"
#    user = Hobo.user_model.authenticate(params[:login], params[:password])
    if params[:login] != nil and params[:password] != nil
      logger.info( "authenticate " + params[:login] + " " + params[:password])
      user = User.authenticate(params[:login], params[:password])
      if user
        puts "login in as " + params[:login]

        session[:logged_in] = true
        session[:current_user] = user
        self.current_user = user
        if params[:remember_me] == "1"
          self.current_user.remember_me
          cookies[:auth_token] = { :value => self.current_user.remember_token ,
                                   :expires => self.current_user.remember_token_expires_at }
        end
      
        # shouldn't I be checking for expired permissions here?
        if current_user.super_user?
          puts "logged in as admin"
          redirect_back_or_default(:controller => 'supplements', :action => 'index')
        else
          redirect_back_or_default(:controller => 'supplements', :action => 'index')
        end
        #flash[:notice] = "You have logged in"
      
      else
        flash[:notice] = "You did not provide a valid login and password"
        redirect_back_or_default(:action => 'index')
      end
    else
      if params[:login] == nil
        logger.info("params[:login] == nil")
      elsif params[:password] == nil
        logger.info("params[:password] == nil")
      else
        logger.info("weird login problem")
      end
    end
  end

  def add_user
    if not session[:logged_in] or not current_user.super_user?
      redirect_to(:action => :index)
    end
    @user = User.new(params[:user])
    #@user = Hobo.user_model.new(params[:user])
    return unless request.post?
    @user.save!
    #self.current_user = @user
    redirect_to(:controller => :users)
    #flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'add_user'
  end

  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    session[:logged_in] = false
    #flash[:notice] = "You have been logged out."
    redirect_back_or_default(:action => 'index')
  end
 
  def get_formatted_time(elapsed)
    formatted_time = ""
    hours = (elapsed / (60 * 60)).to_i
    minutes = ((elapsed / 60) - (hours * 60)).to_i
    seconds = (elapsed % 60).to_i
    formatted_time += pad(hours) + ":"
    formatted_time += pad(minutes) + ":"
    formatted_time += pad(seconds)
  end
  
end

