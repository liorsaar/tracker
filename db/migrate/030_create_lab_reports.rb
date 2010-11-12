class CreateLabReports < ActiveRecord::Migration
  def self.up
    create_table :lab_reports do |t|
      t.integer :lab_report_definition_id
      t.integer :customer_id
      t.integer :clinician_id
      t.integer :lab_clinician_id
      t.datetime :date_time_sample_taken
      t.datetime :date_time_analyzed
      t.string :identifier1
      t.string :identifier2
      t.string :identifier3
      t.string :identifier4

      t.timestamps
    end
  end

  def self.down
    drop_table :lab_reports
  end
end
