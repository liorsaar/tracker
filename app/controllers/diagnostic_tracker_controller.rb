class DiagnosticTrackerController < ApplicationController

  def set_vars
    # set up variable for where current out of range test results get displayed
    @out_of_range_test_ids = []
    @out_of_range_substance_ids = []
    @out_of_range_ref_ranges = []
    @out_of_range_flags = []
    @out_of_range_dates = []
    @total_tests = 0
    @total_out_of_range_tests = 0
    @customer_id = Customer.find_by_user_id(session[:current_user].id)
    @lab_reports = LabReport.find_all_by_customer_id(@customer_id, :order => 'date_time_sample_taken DESC', :include => 'single_test_results')
    @lab_reports.each do | lab_report |
      lab_report.single_test_results.each do | single_test_result |
        @total_tests += 1 # could be faster outside the loop
        single_test_definition = SingleTestDefinition.find(single_test_result.single_test_definition_id)
        if session[:expert_id] != nil
          ref_rangeish_thing = ReferenceRange.find_by_single_test_definition_id_and_expert_id(single_test_result.single_test_definition_id, session[:expert_id])
          if ref_rangeish_thing == nil
            ref_rangeish_thing = single_test_definition
          end
        else
          ref_rangeish_thing = single_test_definition
        end
        if out_of_range?(single_test_result, ref_rangeish_thing)
          @total_out_of_range_tests += 1 
          if not @out_of_range_substance_ids.include?(single_test_definition.substance_id)
            @out_of_range_test_ids << single_test_result.id
            @out_of_range_substance_ids << single_test_definition.substance_id
            @out_of_range_ref_ranges << ref_range_display(ref_rangeish_thing)
            @out_of_range_flags << get_flag(single_test_result, ref_rangeish_thing)
            @out_of_range_dates << lab_report.date_time_sample_taken.to_date
          end
        end
      end
    end
    @out_of_range_substance_ids.each do | thing |
      puts Substance.find(thing).name + " marked as out of range"
    end
    # set up variables for all prior tests for substances which are currently out of range
    @prior_result_ids = []
    @prior_ref_ranges = []
    @prior_flags = []
    @prior_result_dates = []
    @lab_reports.each do | lab_report |
      lab_report.single_test_results.each do | single_test_result |
        if not @out_of_range_test_ids.include?(single_test_result.id)
          single_test_definition = SingleTestDefinition.find(single_test_result.single_test_definition_id)
          if session[:expert_id] != nil
            ref_rangeish_thing = ReferenceRange.find_by_single_test_definition_id_and_expert_id(single_test_result.single_test_definition_id, session[:expert_id])
            if ref_rangeish_thing == nil
              ref_rangeish_thing = single_test_definition
            end
          else
            ref_rangeish_thing = single_test_definition
          end
          if @out_of_range_substance_ids.include?(single_test_definition.substance_id)
             @prior_result_ids << single_test_result.id
             @prior_ref_ranges << ref_range_display(ref_rangeish_thing)
             @prior_flags << get_flag(single_test_result, ref_rangeish_thing)
             @prior_result_dates << lab_report.date_time_sample_taken
          end
        end
      end
    end
  end
  
  def index
    set_vars
  end
      
  def toggle_test_result_selected    
    if session[:selected_tests] == nil
      session[:selected_tests] = Hash.new
    end
    if session[:selected_tests][params[:id]] == nil or session[:selected_tests][params[:id]] == false
      session[:selected_tests][params[:id]] = true
    else
      session[:selected_tests][params[:id]] = false
    end
    puts session[:selected_tests].length.to_s
    session[:selected_tests].keys.each do | substance_id |
      if session[:selected_tests][substance_id] == true
        puts Substance.find(substance_id).name + " is selected"
      else
        puts Substance.find(substance_id).name + " is NOT selected"
      end
    end
    render :nothing => true
  end

  def get_test_result_data
    session[:out_of_range_substance_ids] = []
    session[:trend_data] = Hash.new    
    session[:trend_references] = Hash.new    
    customer_id = Customer.find_by_user_id(session[:current_user].id)
    lab_reports_descending = LabReport.find_all_by_customer_id(customer_id, :order => 'date_time_sample_taken DESC', :include => 'single_test_results')
    lab_reports_descending.each do | lab_report |
      lab_report.single_test_results.each do | single_test_result |
        single_test_definition = SingleTestDefinition.find(single_test_result.single_test_definition_id)
        if session[:expert_id] != nil
          ref_rangeish_thing = ReferenceRange.find_by_single_test_definition_id_and_expert_id(single_test_result.single_test_definition_id, session[:expert_id])
          if ref_rangeish_thing == nil
            ref_rangeish_thing = single_test_definition
          end
        else
          ref_rangeish_thing = single_test_definition
        end
        if out_of_range?(single_test_result, ref_rangeish_thing)
          if not session[:out_of_range_substance_ids].include?(single_test_definition.substance_id)
            session[:out_of_range_substance_ids] << single_test_definition.substance_id
          end
        end
      end
    end
    # set up varibles for graphing of selected currently out of range substances for trend analysis        
    lab_reports_ascending = LabReport.find_all_by_customer_id(customer_id, :order => 'date_time_sample_taken ASC', :include => 'single_test_results')
    lab_reports_ascending.each do | lab_report |
      lab_report.single_test_results.each do | single_test_result |
        single_test_definition = SingleTestDefinition.find(single_test_result.single_test_definition_id)
        if session[:out_of_range_substance_ids].include?(single_test_definition.substance_id)
          if session[:trend_data][single_test_definition.substance_id.to_s] == nil
            puts "RESETTING session[:trend_data] for id = " + single_test_definition.substance_id.to_s
            session[:trend_data][single_test_definition.substance_id.to_s] = []
            session[:trend_references][single_test_definition.substance_id.to_s] = []
          end
          session[:trend_data][single_test_definition.substance_id.to_s] << [lab_report.date_time_sample_taken.to_i * 1000, single_test_result.result_amount]         
          session[:trend_references][single_test_definition.substance_id.to_s] << [lab_report.date_time_sample_taken.to_i * 1000, get_reference(single_test_definition)]
          puts "saving trend data for substance id = " + single_test_definition.substance_id.to_s
          puts session[:trend_data][single_test_definition.substance_id.to_s]          
        end
      end
    end
    
    puts "session[:out_of_range_substance_ids].length:" + session[:out_of_range_substance_ids].length.to_s
    puts "session[:trend_data].length:" + session[:trend_data].length.to_s
    if session[:selected_tests] != nil
      data = []
      labels = []
      session[:out_of_range_substance_ids].each do | substance_id |
        puts "checking to see if " + Substance.find(substance_id).name + " is selected"
        session[:selected_tests].keys.each do | temp_substance_id |
          if session[:selected_tests][temp_substance_id] == true
            puts "get_test_result_data:" + Substance.find(temp_substance_id).name + " is selected"
          else
            puts "get_test_result_data:" + Substance.find(temp_substance_id).name + " is NOT selected"
          end
        end
        if session[:selected_tests][substance_id.to_s] == true
          puts "data for:" + Substance.find(substance_id).name +  "substance id = " + substance_id.to_s
          puts session[:trend_data][substance_id.to_s]
          data << session[:trend_data][substance_id.to_s]
          labels << Substance.find(substance_id).name
          data << session[:trend_references][substance_id.to_s]
          labels << Substance.find(substance_id).name + " reference amount"
        end
      end
    end
    render :json => { :data => data, :labels => labels}
  end

  def get_reference(test_definition)
    result = 0
    if test_definition.lower_limit != nil
      result = test_definition.lower_limit
    elsif test_definition.upper_limit != nil
      result = test_definition.upper_limit
    end
    return result
  end

  def out_of_range?(single_test_result, ref_rangeish_thing)
    result = false   
    if ref_rangeish_thing.lower_limit != nil and single_test_result.result_amount < ref_rangeish_thing.lower_limit
      result = true
    elsif ref_rangeish_thing.upper_limit != nil and single_test_result.result_amount > ref_rangeish_thing.upper_limit
      result = true
    end    
    return result
  end

  def get_flag(single_test_result, ref_rangeish_thing)
    result = "OK"
    if ref_rangeish_thing.lower_limit != nil and single_test_result.result_amount < ref_rangeish_thing.lower_limit
      result = "LOW"
    elsif ref_rangeish_thing.upper_limit != nil and single_test_result.result_amount > ref_rangeish_thing.upper_limit
      result = "HIGH"
    end    
    return result
  end

  def ref_range_display(ref_rangeish_thing)
    result = ""
    if ref_rangeish_thing.lower_limit != nil
      if ref_rangeish_thing.upper_limit != nil
        result = ref_rangeish_thing.lower_limit.to_s + "-" + ref_rangeish_thing.upper_limit.to_s
      else
        result = ">" + ref_rangeish_thing.lower_limit.to_s
      end
    elsif ref_rangeish_thing.upper_limit != nil
      result = "<" + ref_rangeish_thing.upper_limit.to_s
    end    
    return result
  end

  def change_expert
    if params[:expert] != nil
      session[:expert_id] = params[:expert][:id]
    else
      session[:expert_id] = nil
    end
    redraw
  end
    
end
=begin
node1 = [1171612800000,45.0]
node2 = [1213081200000,34.0]
node3 = [1252566000000,23.0]
node4 = [1260432000000,78.0]
data << [node1,node2,node3, node4]
saving trend data: 
1171612800000
45.0
1213081200000
34.0
1252566000000
23.0

      node1 = [1175378400000,1]
      node2 = [1180648800000,2]
      node3 = [1185919200000,3]
      node4 = [1191189600000,4]
      data << [node1,node2,node3,node4]
      data << [[1175378400000,3],[1180648800000,5],[1185919200000,7],[1191189600000,9]]
      data << [[1175378400000,5],[1180648800000,1],[1185919200000,6],[1191189600000,2]]
      data << [[1175378400000,8],[1180648800000,7],[1185919200000,6],[1191189600000,5]]
=end