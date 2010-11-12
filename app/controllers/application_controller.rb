# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
#require 'authenticated_system'

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  before_filter :login_required, :except => 'login'
  before_filter :set_up_tabs
  filter_parameter_logging "password"

  layout 'application'


  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_JKDev_session_id'
  
  private
  def set_up_tabs
    @tabs = []

    @tabs << ['Instructions', 'instructions']
    @tabs << ['Lab&nbsp;Report&nbsp;Types', 'lab_report_types']
    @tabs << ['Lab&nbsp;Report&nbsp;Definitions', 'lab_report_definitions']
    @tabs << ['Report&nbsp;Providers', 'report_providers']
    @tabs << ['Categories', 'categories']
    @tabs << ['Lab&nbsp;Reports', 'lab_reports']
    @tabs << ['Single&nbsp;Test&nbsp;Definitions', 'single_test_definitions']
    @tabs << ['Single&nbsp;Test&nbsp;Results', 'single_test_results']
    @tabs << ['Labs', 'labs']
    @tabs << ['Clinicians', 'clinicians']
    @tabs << ['Customers', 'customers']
    @tabs << ['Substances', 'substances']
    @tabs << ['Test&nbsp;Vehicles', 'test_vehicles']
    @tabs << ['Reference&nbsp;Ranges', 'reference_ranges']
    @tabs << ['Experts', 'experts']
    @tabs << ['Units&nbsp;Of&nbsp;Measure', 'units_of_measure']
  end

  def verify_credentials
    if not session[:logged_in] or not current_user.super_user?
      redirect_to(:controller => :front, :action => :index)
      return false
    else
      return true
    end
  end
  
end
