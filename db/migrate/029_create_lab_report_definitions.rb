class CreateLabReportDefinitions < ActiveRecord::Migration
  def self.up
    create_table :lab_report_definitions do |t|
      t.integer :lab_report_type_id
      t.integer :report_provider_id
      t.integer :test_vehicle_id
      t.integer :number_of_category_layers # de-normalized, do we really need this?
      t.string :number_field_name1 # these are numbers assigned by the lab, they vary form lab to lab
      t.string :number_field_name2 
      t.string :number_field_name3
      t.string :number_field_name4

      t.timestamps
    end
  end

  def self.down
    drop_table :lab_report_definitions
  end
end
