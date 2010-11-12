class CreateLabReportTypes < ActiveRecord::Migration
  def self.up
    create_table :lab_report_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :lab_report_types
  end
end
