class SupplementsController < ApplicationController

  #hobo_model_controller

  #auto_actions :all

  def set_vars
    @supplements = Supplement.find(:all)
    @user_supplements = UserSupplement.find_all_by_user_id(session[:current_user].id)
    @experts = Expert.find(:all)
    set_user_subcomponents
    puts "@user_supplements.length " + @user_supplements.length.to_s
  end
  
  def index
    set_vars
  end
  
  # this should only get called when the user_supplements change
  def set_user_subcomponents
    UserSubcomponent.delete_all
    @user_supplements.each do | user_supplement |
      supplement = Supplement.find(user_supplement.supplement_id)
      if user_supplement.custom_dosage_per_day != nil and user_supplement.custom_dosage_per_day > 0
        pills_per_day = user_supplement.custom_dosage_per_day
      elsif supplement.dosage != nil and supplement.doses_per_day != nil
        pills_per_day =  supplement.dosage * supplement.doses_per_day
      else
        pills_per_day = 0
      end
      ingredients = Ingredient.find_all_by_supplement_id(user_supplement.supplement_id)
      ingredients.each do | ingredient |
        subcomponent = Subcomponent.find(ingredient.subcomponent_id)
        user_subcomponent = UserSubcomponent.find_by_user_id_and_subcomponent_id(user_supplement.user_id, ingredient.subcomponent_id)
        if user_subcomponent == nil 
          user_subcomponent = UserSubcomponent.create({:user_id => user_supplement.user_id, :subcomponent_id => ingredient.subcomponent_id})
          if ingredient.quantity != nil and pills_per_day != nil
            user_subcomponent.total = ingredient.quantity * pills_per_day
            user_subcomponent.unit_of_measure_id = ingredient.unit_of_measure_id
          end
        else
          if ingredient.quantity != nil and pills_per_day != nil
            user_subcomponent.total += ingredient.quantity * pills_per_day
          end
        end
        user_subcomponent.save
        threshold = Threshold.find_by_subcomponent_id_and_expert_id(subcomponent.id, session[:expert_id])
  		  if threshold != nil and threshold.lower_limit != nil and threshold.upper_limit != nil
  		    range = threshold.upper_limit - threshold.lower_limit
  		    midpoint = (threshold.upper_limit + threshold.lower_limit) / 2
  		    if threshold.recommended_amount != nil # override the mathematically calculated midpoint
  		      midpoint = threshold.recommended_amount		      
	        end
	        distance = user_subcomponent.total - midpoint
	        imbalance = (distance * 100)/range
	        user_subcomponent.percent_out = imbalance
	        user_subcomponent.save
	        puts "range " + range.to_s
	        puts "midpoint " + midpoint.to_s
	        puts "distance " + distance.to_s
	        puts "imbalance " + imbalance.to_s
		    end
      end
    end
    @user_subcomponents = UserSubcomponent.find_all_by_user_id(session[:current_user].id, :order => 'ABS(percent_out) DESC')
  end
=begin  
  def set_user_subcomponents
    @user_subcomponents = []
    @user_subcomponent_totals = Hash.new
    @user_subcomponent_uoms = Hash.new
    @user_subcomponent_percent_out = Hash.new
    @user_supplements.each do | user_supplement |
      if user_supplement.custom_dosage_per_day != nil and user_supplement.custom_dosage_per_day > 0
        pills_per_day = user_supplement.custom_dosage_per_day
      else
        supplement = Supplement.find(user_supplement.supplement_id)
        pills_per_day =  supplement.dosage * supplement.doses_per_day
      end
      ingredients = Ingredient.find_all_by_supplement_id(user_supplement.supplement_id)
      ingredients.each do | ingredient |
        subcomponent = Subcomponent.find(ingredient.subcomponent_id)
        if not @user_subcomponents.include?(subcomponent.name)
          @user_subcomponents << subcomponent.name
          if ingredient.quantity != nil and pills_per_day != nil
            @user_subcomponent_totals[subcomponent.name] = ingredient.quantity * pills_per_day
            @user_subcomponent_uoms[subcomponent.name] = UnitOfMeasure.find(ingredient.unit_of_measure_id).name
          end
        else
          @user_subcomponent_totals[subcomponent.name] += ingredient.quantity * pills_per_day
        end
      end
    end
  end
  
  def float_warnings_to_top
    subcomponent_counter = 0
	  @user_subcomponents.each do | subcomponent |
		  threshold = Threshold.find_by_subcomponent_id_and_expert_id(Subcomponent.find_by_name(subcomponent).id, session[:expert_id])
		  class_concat = "" 
		  if threshold != nil and @user_subcomponent_totals[subcomponent] > threshold.upper_limit
			  class_concat = "over_threshold"
		  end %>
		<tr>
			<td><%= subcomponent %></td><td class="<%= class_concat %>"><%= @user_subcomponent_totals[subcomponent] %></td><td><%= @user_subcomponent_uoms[subcomponent] %></td>
			  if threshold != nil
				<td><%= threshold.lower_limit %></td><td><%= threshold.recommended_amount %></td><td><%= threshold.upper_limit %></td>
			  else  
				<td></td><td></td><td></td>
			  end
		</tr>
		  subcomponent_counter += 1
	  end
  end 
=end  
  def autocomplete_names
    respond_to do |format|
      #format.html
      format.js do
        @auto_supplements = Supplement.find(:all, :conditions => ['brand_name LIKE ?', "%#{params[:search]}%"])
      end
    end
  end
  
  def redraw
    set_vars
    render :update do | page |
      page.replace_html "user_supplements", :partial => 'user_supplements'
      page.replace_html "aggregates", :partial => 'aggregates'
    end     
  end
  
  def draw_supplement_details
  	@ingredients = Ingredient.find_all_by_supplement_id(params[:supplement_id])
    render :update do | page |
      page.replace_html "complete_supplement_list", :partial => 'complete_supplement_list'
    end     
  end
  
  def redraw_content_editor
    set_content_editor_vars
    render :update do | page |
      page.replace_html "whole_page", :partial => 'content_editor'
    end     
  end
  
  def view_user_supplement_detail
    name = params[:supplement][:name]
    session[:supplement_holder] = Supplement.find_by_brand_name(name)
    redraw
  end
  
  def change_expert
    if params[:expert] != nil
      session[:expert_id] = params[:expert][:id]
    else
      session[:expert_id] = nil
    end
    redraw
  end
    
  def add_user_supplement
    user_supplement = UserSupplement.new(:supplement_id => session[:supplement_holder].id, :user_id => session[:current_user].id)
    user_supplement.save
    redraw
  end
  
  def destroy_user_supplement
    user_supplement = UserSupplement.find(params[:id])
    user_supplement.destroy
    redraw
  end
  
  def expand_user_supplement
    user_supplement = UserSupplement.find(params[:id])
    user_supplement.is_expanded = 1
    user_supplement.save
    redraw
  end
  
  def unexpand_user_supplement
    user_supplement = UserSupplement.find(params[:id])
    user_supplement.is_expanded = 0
    user_supplement.save
    redraw
  end
  
  def set_content_editor_vars
    @supplements = Supplement.find(:all, :order => 'brand_name ASC')
    @subcomponents = Subcomponent.find(:all, :order => 'name ASC')
    @certifiers = Certifier.find(:all)
    @experts = Expert.find(:all)
  end
  
  def content_editor
    set_content_editor_vars
    session[:content_edit_mode] = 'supplements'
  end
  
  def content_editor_expand_supplement
    supplement = Supplement.find(params[:id])
    supplement.expanded = 1
    supplement.save
    redraw_content_editor
  end
  
  def content_editor_contract_supplement
    supplement = Supplement.find(params[:id])
    supplement.expanded = 0
    supplement.save
    redraw_content_editor
  end
  
  def content_editor_expand_subcomponent
    subcomponent = Subcomponent.find(params[:id])
    subcomponent.expanded = 1
    subcomponent.save
    redraw_content_editor     
  end
  
  def content_editor_contract_subcomponent
    subcomponent = Subcomponent.find(params[:id])
    subcomponent.expanded = 0
    subcomponent.save
    redraw_content_editor     
  end
  
  def content_editor_create_supplement
    supplement = Supplement.new(params[:supplement])
    supplement.save
    redraw_content_editor    
  end
        
  def content_editor_update_supplement
    supplement = Supplement.find(params[:id])
    supplement[params[:field]] = params[:value]
    supplement.save
    redraw_content_editor     
  end
  
  def content_editor_update_ingredient
    ingredient = Ingredient.find(params[:id])
    ingredient[params[:field]] = params[:value]
    ingredient.save
    redraw_content_editor     
  end
  
  def content_editor_update_subcomponent
    subcomponent = Subcomponent.find(params[:id])
    subcomponent[params[:field]] = params[:value]
    subcomponent.save
    redraw_content_editor     
  end
  
  def content_editor_update_certifier
    certifier = Certifier.find(params[:id])
    certifier[params[:field]] = params[:value]
    certifier.save
    redraw_content_editor     
  end
  
  def content_editor_update_expert
    expert = Expert.find(params[:id])
    expert[params[:field]] = params[:value]
    expert.save
    redraw_content_editor     
  end
    
  def content_editor_update_alert
    alert = Alert.find(params[:id])
    alert.message = params[:value]
    alert.save
    redraw_content_editor     
  end
    
  def content_editor_change_ingredient_subcomponent
    id = params[:ingredient][:id]
    value = params[:ingredient]['subcomponent_id']
    ingredient = Ingredient.find(id)
    ingredient.subcomponent_id = value
    ingredient.save
    redraw_content_editor     
  end
  
  def content_editor_change_ingredient_uom
    id = params[:ingredient][:id]
    value = params[:ingredient]['unit_of_measure_id']
    ingredient = Ingredient.find(id)
    ingredient.unit_of_measure_id = value
    ingredient.save
    redraw_content_editor     
  end
  
  def content_editor_update_supplement_field
    id = params[:supplement][:id]
    field = params[:supplement][:field]
    value = params[:supplement][field]
    supplement = Supplement.find(id)
    supplement[field] = value
    supplement.save
    redraw_content_editor
  end
  
  def content_editor_update_ingredient_field
    id = params[:ingredient][:id]
    field = params[:ingredient][:field]
    value = params[:ingredient][field]
    ingredient = Ingredient.find(id)
    ingredient[field] = value
    ingredient.save
    redraw_content_editor
  end
  
  def content_editor_create_ingredient
    ing = Ingredient.new(params[:ingredient])
    ing.save
    redraw_content_editor
  end
  
  def content_editor_create_subcomponent
    sc = Subcomponent.new(params[:subcomponent])
    sc.save
    redraw_content_editor
  end
  
  def content_editor_destroy_supplement
    supplement = Supplement.find(params[:id])
    supplement.destroy
    redraw_content_editor
  end
  
  def content_editor_destroy_ingredient
    ingredient = Ingredient.find(params[:id])
    ingredient.destroy
    redraw_content_editor
  end
  
  def content_editor_destroy_subcomponent
    subcomponent = Subcomponent.find(params[:id])
    subcomponent.destroy
    redraw_content_editor
  end
  
  def content_editor_destroy_certifier    
    certifier = Certifier.find(params[:id])
    certifier.destroy
    redraw_content_editor
  end
  
  def content_editor_destroy_expert    
    expert = Expert.find(params[:id])
    expert.destroy
    redraw_content_editor
  end
  
  def content_editor_destroy_threshold    
    threshold = Threshold.find(params[:id])
    threshold.destroy
    redraw_content_editor
  end
  
  def content_editor_destroy_info    
    info = Info.find(params[:id])
    info.destroy
    redraw_content_editor
  end

  def content_editor_create_certifier
    certifier = Certifier.new(params[:certifier])
    certifier.save
    redraw_content_editor
  end
  
  def content_editor_create_expert
    expert = Expert.new(params[:expert])
    expert.save
    redraw_content_editor
  end
  
  def content_editor_create_threshold 
    threshold  = Threshold.new(params[:threshold])
    threshold .save
    redraw_content_editor
  end
  
  def content_editor_add_alert
    alert = Alert.new(params[:alert])
    alert.save
    redraw_content_editor
  end
  
  def content_editor_create_certification
    certification = Certification.new(params[:certification])
    certification.save
    redraw_content_editor
  end
  
  def content_editor_change_certification
    certification = Certification.find(params[:certification][:id])
    certification.certifier_id = params[:certification][:certifier_id]
    certification.save
    redraw_content_editor
  end
  
  def content_editor_destroy_certification    
    certification = Certification.find(params[:id])
    certification.destroy
    redraw_content_editor
  end
  
  def content_editor_add_info 
    @info  = Info.new(params[:info])
    @info.save    
    redraw_content_editor
  end
  
  def content_editor_update_paragraph1
    @info = Info.find(params[:id])
    @info.paragraph1 = params[:value]
    @info.save
    redraw_content_editor
  end
  
  def content_editor_update_paragraph2
    info = Info.find(params[:id])
    info.paragraph2 = params[:value]
    info.save
    redraw_content_editor
  end
  
  def content_editor_update_paragraph3
    info = Info.find(params[:id])
    info.paragraph3 = params[:value]
    info.save
    redraw_content_editor
  end
  
  def content_editor_update_paragraph4
    info = Info.find(params[:id])
    info.paragraph4 = params[:value]
    info.save
    redraw_content_editor
  end
  
end
