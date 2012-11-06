desc 'Setup DB so it will run'
task :setup do
  puts 'Trying to create database...'
  `psql -c "CREATE DATABASE core_data_clients"`
  puts 'Done'
end

# Run setup by default
task :default => :setup
