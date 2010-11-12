# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101002001905) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "full_domain"
    t.datetime "deleted_at"
    t.integer  "subscription_discount_id"
    t.boolean  "is_active",                :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alerts", :force => true do |t|
    t.integer  "supplement_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certifications", :force => true do |t|
    t.integer  "supplement_id"
    t.integer  "certifier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certifiers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clinicians", :force => true do |t|
    t.string   "name"
    t.integer  "contact_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_infos", :force => true do |t|
    t.string   "phone"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "contact_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "infos", :force => true do |t|
    t.integer  "supplement_id"
    t.integer  "number_of_paragraphs"
    t.string   "paragraph1"
    t.string   "paragraph2"
    t.string   "paragraph3"
    t.string   "paragraph4"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", :force => true do |t|
    t.integer  "supplement_id"
    t.integer  "subcomponent_id"
    t.integer  "sequence_number"
    t.integer  "quantity"
    t.integer  "unit_of_measure_id"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_clinicians", :force => true do |t|
    t.string   "name"
    t.integer  "contact_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_report_definitions", :force => true do |t|
    t.integer  "lab_report_type_id"
    t.integer  "report_provider_id"
    t.integer  "test_vehicle_id"
    t.integer  "number_of_category_layers"
    t.string   "number_field_name1"
    t.string   "number_field_name2"
    t.string   "number_field_name3"
    t.string   "number_field_name4"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_report_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_reports", :force => true do |t|
    t.integer  "lab_report_definition_id"
    t.integer  "customer_id"
    t.integer  "clinician_id"
    t.integer  "lab_clinician_id"
    t.datetime "date_time_sample_taken"
    t.datetime "date_time_analyzed"
    t.string   "identifier1"
    t.string   "identifier2"
    t.string   "identifier3"
    t.string   "identifier4"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labs", :force => true do |t|
    t.string   "name"
    t.integer  "contact_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "password_resets", :force => true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.string   "remote_ip"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reference_ranges", :force => true do |t|
    t.integer "expert_id"
    t.integer "single_test_definition_id"
    t.float   "reference_amount"
    t.float   "lower_limit"
    t.float   "upper_limit"
  end

  create_table "report_providers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "single_test_definition_category_joins", :force => true do |t|
    t.integer  "category_or_subcategory_id"
    t.integer  "single_test_definition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "single_test_definitions", :force => true do |t|
    t.integer  "substance_id"
    t.integer  "unit_of_measure_id"
    t.integer  "test_vehicle_id"
    t.integer  "lab_id"
    t.float    "reference_amount"
    t.float    "lower_limit"
    t.float    "upper_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "retest_interval",    :default => 12
  end

  create_table "single_test_results", :force => true do |t|
    t.integer  "single_test_definition_id"
    t.integer  "lab_report_id"
    t.float    "result_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcomponents", :force => true do |t|
    t.string   "name"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "expanded",   :default => 0
  end

  create_table "subscription_discounts", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.decimal  "amount",     :precision => 6, :scale => 2, :default => 0.0
    t.boolean  "percent"
    t.date     "start_on"
    t.date     "end_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_payments", :force => true do |t|
    t.integer  "account_id"
    t.integer  "subscription_id"
    t.decimal  "amount",          :precision => 10, :scale => 2, :default => 0.0
    t.string   "transaction_id"
    t.boolean  "setup"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_plans", :force => true do |t|
    t.string   "name"
    t.decimal  "amount",         :precision => 10, :scale => 2
    t.integer  "user_limit"
    t.integer  "renewal_period",                                :default => 1
    t.decimal  "setup_amount",   :precision => 10, :scale => 2
    t.integer  "trial_period",                                  :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.decimal  "amount",               :precision => 10, :scale => 2
    t.datetime "next_renewal_at"
    t.string   "card_number"
    t.string   "card_expiration"
    t.string   "state",                                               :default => "trial"
    t.integer  "subscription_plan_id"
    t.integer  "account_id"
    t.integer  "user_limit"
    t.integer  "renewal_period",                                      :default => 1
    t.string   "billing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "substances", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplements", :force => true do |t|
    t.string   "brand_name"
    t.integer  "capsules_per_bottle"
    t.integer  "dosage"
    t.integer  "doses_per_day"
    t.integer  "take_with_food"
    t.string   "bar_code"
    t.string   "product_code"
    t.integer  "certifier_id"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "expanded",            :default => 0
  end

  create_table "test_categories", :force => true do |t|
    t.integer  "lab_report_definition_id"
    t.string   "name"
    t.integer  "sequence_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_subcategories", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "sequence_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_vehicles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "thresholds", :force => true do |t|
    t.integer  "expert_id"
    t.integer  "subcomponent_id"
    t.integer  "unit_of_measure_id"
    t.integer  "recommended_amount"
    t.integer  "lower_limit"
    t.integer  "upper_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_of_measures", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_subcomponents", :force => true do |t|
    t.integer  "user_id"
    t.integer  "subcomponent_id"
    t.integer  "unit_of_measure_id"
    t.integer  "total"
    t.integer  "percent_out"
    t.integer  "sequence_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_supplements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "supplement_id"
    t.integer  "sequence_number"
    t.integer  "custom_dosage_per_day"
    t.integer  "is_expanded",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "activation_code"
    t.integer  "account_id"
    t.boolean  "is_active"
  end

end
