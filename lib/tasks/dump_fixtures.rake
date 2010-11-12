    # to use this call rake dump_fixtures.rake from within your rails directory
    # to load the fixtures back up you can call rake db:fixtures:load (you may have to specify RAILS_ENV if not in development environment)
    
    # Tables to skip because they are populated by migrations
    # default_tables: Tables populated by migration 100 & 160 default data
    default_tables = []   
    # empty_tables: Tables that should always be empty or left alone
    empty_tables = ["practice_sessions", "practice_session_answers", "sessions", "schema_info"]
    
    desc 'Dump a database to yaml fixtures.  Set environment variables DB
    and DEST to specify the target database and destination path for the
    fixtures.  DB defaults to development and DEST defaults to RAILS_ROOT/
    test/fixtures.'
    task :dump_fixtures => :environment do
       path = ENV['DEST'] || "#{RAILS_ROOT}/test/fixtures"
       db   = ENV['DB']   || 'staging'
       sql  = 'SELECT * FROM %s'

       ActiveRecord::Base.establish_connection(db)
       ActiveRecord::Base.connection.select_values('show tables').each do |table_name|
         i = '000'
         if default_tables.index(table_name) == nil && empty_tables.index(table_name) == nil
           puts table_name
           File.open("#{path}/#{table_name}.yml", 'wb') do |file|

	           file.write ActiveRecord::Base.connection.select_all(sql % table_name).inject({}) { |hash, record|
	             hash["#{table_name}_#{i.succ!}"] = record
	             hash
	           }.to_yaml
           end
         end
       end
    end

