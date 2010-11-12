class CreateReportProviders < ActiveRecord::Migration
  def self.up
    create_table :report_providers do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :report_providers
  end
end
