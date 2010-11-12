class DiagnosticsContentEditorController < ApplicationController

  def index
    redirect_to(:action => 'content_editor')
  end

  def content_editor
    session[:content_edit_mode] = 'diagnostics'
    if @main_tab.blank?
      @main_tab = 'instructions'    
    end
  end

  def instructions
    @main_tab = 'instructions'    
    render :action => 'content_editor'
  end

  def redraw(tab)
    render :update do | page |
      page.replace_html "sub_tab", :partial => tab
    end
  end

  def set_content_editor_vars
    @categories = TestCategory.find(:all)
    @labs = Lab.find(:all)
    @clinicians = Clinician.find(:all)
    @customers = Customer.find(:all)
    @substances = Substance.find(:all)
    @vehicles = TestVehicle.find(:all)
    @single_test_definitions = SingleTestDefinition.find(:all)
    @lab_report_definitions = LabReportDefinition.find(:all)
    @reference_ranges = ReferenceRange.find(:all)
    @experts = Expert.find(:all)
    @lab_reports = LabReport.find(:all)
    @single_test_results = SingleTestResult.find(:all)
    @units_of_measure = UnitOfMeasure.find(:all)
  end

  def update
    active_record_sub_class = params[:object].constantize
    this_object = active_record_sub_class.find(params[:id])
    this_object[params[:field]] = params[:value]
    this_object.save
    set_content_editor_vars
    redraw params[:redraw]
  end

  def lab_report_types
    if request.post?
      lab_report_type = LabReportType.new(params[:lab_report_type])
      lab_report_type.save
    end
    @main_tab = 'lab_report_types'
    @lab_report_types = LabReportType.find(:all)
    render :action => 'content_editor'
  end

  def delete_lab_report_type
    lab_report_type = LabReportType.find(params[:id])
    lab_report_type.destroy
    @lab_report_types = LabReportType.find(:all)
    redraw 'lab_report_types'
  end

  def lab_report_definitions
    if request.post?
      lab_report_definition = LabReportDefinition.new(params[:lab_report_definition])
      lab_report_definition.save
    end
    @main_tab = 'lab_report_definitions'
    @lab_report_definitions = LabReportDefinition.find(:all)
    render :action => 'content_editor'
  end

  def delete_lab_report_definition
    lab_report_definition = LabReportDefinition.find(params[:id])
    lab_report_definition.destroy
    @lab_report_definitions = LabReportDefinition.find(:all)
    redraw 'lab_report_definitions'
  end

  def report_providers
    if request.post?
      report_provider = ReportProvider.new(params[:report_provider])
      report_provider.save
    end
    @main_tab = 'report_providers'
    @report_providers = ReportProvider.find(:all)
    render :action => 'content_editor'
  end

  def delete_report_provider
    report_provider = ReportProvider.find(params[:id])
    report_provider.destroy
    @report_providers = ReportProvider.find(:all)
    redraw 'report_providers'
  end

# categories are not really functioning
# they should be part of the lab report definition form
  def create_category
    @category = TestCategory.new(params[:category])
    @category.save
    @categories = TestCategory.find(:all)
    redraw 'categories'
  end

  def delete_category
    @category = TestCategory.find(params[:id])
    @category.destroy
    @categories = TestCategory.find(:all)
    redraw 'categories'
  end

  def categories
    @main_tab = 'categories'
    @categories = TestCategory.find(:all)    
    render :action => 'content_editor'
  end

  def lab_reports
    if request.post?
      lab_report = LabReport.new(params[:lab_report])
      lab_report.save
    end
    @main_tab = 'lab_reports'
    @lab_reports = LabReport.find(:all)
    render :action => 'content_editor'
  end

  def update_lab_report
    if request.post?
      lab_report = LabReport.find(params[:lab_report][:id])
      lab_report.update_attributes(params[:lab_report])
    end
    @main_tab = 'lab_reports'
    @lab_reports = LabReport.find(:all)
    render :action => 'content_editor'
  end

  def delete_lab_report
    lab_report = LabReport.find(params[:id])
    lab_report.destroy
    @lab_reports = LabReport.find(:all)
    redraw 'lab_reports'
  end

  def single_test_definitions
    if request.post?
      single_test_definition = SingleTestDefinition.new(params[:single_test_definition])
      single_test_definition.save
    end
    @main_tab = 'single_test_definitions'
    @single_test_definitions = SingleTestDefinition.find(:all)
    render :action => 'content_editor'
  end

  def update_single_test_definition
    if request.post?
      single_test_definition = SingleTestDefinition.find(params[:single_test_definition][:id])
      single_test_definition.update_attributes(params[:single_test_definition])
    end
    @main_tab = 'single_test_definitions'
    @single_test_definitions = SingleTestDefinition.find(:all)
    render :action => 'content_editor'
  end

  def delete_single_test_definition
    single_test_definition = SingleTestDefinition.find(params[:id])
    single_test_definition.destroy
    @single_test_definitions = SingleTestDefinition.find(:all)
    redraw 'single_test_definitions'
  end

  def single_test_results
    if request.post?
      single_test_result = SingleTestResult.new(params[:single_test_result])
      single_test_result.save
    end
    @main_tab = 'single_test_results'
    @single_test_results = SingleTestResult.find(:all)
    render :action => 'content_editor'
  end

  def delete_single_test_result
    single_test_result = SingleTestResult.find(params[:id])
    single_test_result.destroy
    @single_test_results = SingleTestResult.find(:all)
    redraw 'single_test_results'
  end

# temporary, until I figure out nesting in Formtastic
  def create_lab
    @lab = Lab.new(params[:lab])
    @lab.save
    @labs = Lab.find(:all)
    redraw 'labs'
  end

  def labs
    if request.post?
      lab = Lab.new(params[:lab])
      lab.save
    end
    @main_tab = 'labs'
    @labs = Lab.find(:all)    
    render :action => 'content_editor'
  end

  def delete_lab
    lab = Lab.find(params[:id])
    lab.destroy
    @labs = Lab.find(:all)
    redraw 'labs'
  end

  # temporary, until I figure out nesting in Formtastic
  def create_clinician
    @clinician = Clinician.new(params[:clinician])
    @clinician.save
    @clinicians = Clinician.find(:all)
    redraw 'clinicians'
  end

  def clinicians
    if request.post?
      clinician = Clinician.new(params[:customer])
      clinician.save
    end
    @main_tab = 'clinicians'
    @clinicians = Clinician.find(:all)    
    render :action => 'content_editor'
  end

  def delete_clinician
    @clinician = Clinician.find(params[:id])
    @clinician.destroy
    @clinicians = Clinician.find(:all)
    redraw 'clinicians'
  end

  def customers
    if request.post?
      customer = Customer.new(params[:customer])
      customer.name = customer.user.username
      customer.save
    end
    @main_tab = 'customers'
    @customers = Customer.find(:all)
    render :action => 'content_editor'
  end

  def delete_customer
    @customer = Customer.find(params[:id])
    @customer.destroy
    @customers = Customer.find(:all)
    redraw 'customers'
  end

  def substances
    if request.post?
      substance = Substance.new(params[:substance])
      substance.save
    end
    @main_tab = 'substances'
    @substances = Substance.find(:all)
    render :action => 'content_editor'
  end

  def delete_substance
    substance = Substance.find(params[:id])
    substance.destroy
    @substances = Substance.find(:all)
    redraw 'substances'
  end

  def change_substance_unit_of_measure
    substance = Substance.find(params[:substance][:id])
    substance.unit_of_measure_id = params[:substance][:unit_of_measure_id]
    substance.save
    @substances = ReferenceRange.find(:all)
    redraw 'substances'
  end

  def test_vehicles
    if request.post?
      test_vehicle = TestVehicle.new(params[:test_vehicle])
      test_vehicle.save
    end
    @main_tab = 'test_vehicles'
    @test_vehicles = TestVehicle.find(:all)
    render :action => 'content_editor'
  end

  def delete_test_vehicle
    test_vehicle = TestVehicle.find(params[:id])
    test_vehicle.destroy
    @test_vehicles = TestVehicle.find(:all)
    redraw 'test_vehicles'
  end

  def reference_ranges
    if request.post?
      reference_range = ReferenceRange.new(params[:reference_range])
      reference_range.save
    end
    @main_tab = 'reference_ranges'
    @reference_ranges = ReferenceRange.find(:all)
    render :action => 'content_editor'
  end

  def delete_reference_range
    reference_range = ReferenceRange.find(params[:id])
    reference_range.destroy
    @reference_ranges = ReferenceRange.find(:all)
    redraw 'reference_ranges'
  end

  def change_reference_range_expert
    reference_range = ReferenceRange.find(params[:reference_range][:id])
    reference_range.expert_id = params[:reference_range][:expert_id]
    reference_range.save
    @reference_ranges = ReferenceRange.find(:all)
    redraw 'reference_ranges'
  end

  def experts
    if request.post?
      expert = Expert.new(params[:expert])
      expert.save
    end
    @main_tab = 'experts'
    @experts = Expert.find(:all)
    render :action => 'content_editor'
  end

  def delete_expert
    expert = Expert.find(params[:id])
    expert.destroy
    @experts = Expert.find(:all)
    redraw 'experts'
  end

  def units_of_measure
    if request.post?
      unit_of_measure = UnitOfMeasure.new(params[:unit_of_measure])
      unit_of_measure.save
    end
    @main_tab = 'units_of_measure'
    @units_of_measure = UnitOfMeasure.find(:all)  
    render :action => 'content_editor'
  end

  def delete_unit_of_measure
    unit_of_measure = UnitOfMeasure.find(params[:id])
    unit_of_measure.destroy
    @units_of_measure = UnitOfMeasure.find(:all)
    redraw 'units_of_measure'
  end

end
