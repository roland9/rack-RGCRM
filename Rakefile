desc 'Setup DB so it will run'
task :setup do
  puts 'Creating database...'
  `psql -c "CREATE DATABASE core_data_clients"`
  puts 'DB created...'
end

# Run setup by default
task :default => :setup
