class PopulateLookupTables < ActiveRecord::Migration
  def self.up
    UnitOfMeasure.create({:name => 'IU'})
    UnitOfMeasure.create({:name => 'mg'})
    UnitOfMeasure.create({:name => 'mcg'})
    UnitOfMeasure.create({:name => 'g'})
    Expert.create({:name => 'Dr. Oz'})
    Expert.create({:name => 'Oprah'})
    Expert.create({:name => 'USDA'})
    Certifier.create({:name => 'NSF'})
    Certifier.create({:name => 'USP'})
    Certifier.create({:name => 'NFLPA'})
  end

  def self.down
  end
end
