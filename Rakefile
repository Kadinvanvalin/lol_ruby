require 'rake'
require 'rspec/core/rake_task'


require_relative 'config/application'

namespace :db do
  desc "drops, creates, migrates then seeds the DB"
  task :reboot do
    puts "RAKEMASTER::5,000::Have you tried turning it off and on again?"
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  end

  desc "create the database"
  task :create  do
    puts "RAKEMASTER::5,000::Creating file #{DB_PATH} if it doesn't exist"
    touch DB_PATH
  end

  desc "drop the database"
  task :drop do
    puts "RAKEMASTER::5,000:: Drop it like it's HOT!! #{DB_PATH} is gone!"
    rm_f DB_PATH
  end

  desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
  task :migrate do
    ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == 'true' : true
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
      ENV["SCOPE"].blank? || (ENV["SCOPE"]) == migration.SCOPE
    end
  end

  desc "populate the test database with sample data"
  task :seed do
    #require the path to the seeds file?
    require APP_ROOT.join('db', 'seeds.rb')
    puts "RAKEMASTER::5,000::seeding. . . "
  end

  desc 'Retreves the current schema version number'
  task :version do
    puts "RAKEMASTER::5,000:: Current version : #{ActiveRecord::Migrator.current_version}"
  end
end

namespace :generate do
  desc "Create an empty migration in db/migrate, e.g., rake generate:migration NAME=create_tasks"
  task :migration do
    #raise an error if generate:migration is run without a name
    unless ENV.has_key?('NAME')
      raise "RAKEMASTER::5,000::Must specificy migration name, e.g., rake generate:migration NAME=create_tasks"
    end
    #the inverse of #underscore to the name of our filename to be
    name  = ENV['NAME'].camelize
    #this is creating a timestamp for the migration, and putting the timestamp and name assigned into a variable
    filename = "%s_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), ENV['NAME'].underscore]
    #building a path for our file
    path = APP_ROOT.join('db','migrate',filename)

    #checks if the file path already exists using exist class method
    if File.exist?(path)
      raise "RAKEMASTER::5,000::File #{path} already exists"
    end

    puts "RAKEMASTER::5,000::Creating #{path}"
    #opens the path with the write option
    File.open(path, 'w+') do |f|
      #writes the migration with the camelized name we gave the file
      f.write("class #{name} <ActiveRecord::Migration \n def change \n end \nend")
    end
  end
end

desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r./config/application"
end

desc "run the specs"
RSpec::Core::RakeTask.new(:spec)

task :default => :specs


