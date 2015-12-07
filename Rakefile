require 'rspec/core/rake_task'
 
RSpec::Core::RakeTask.new :specs do |task|
  task.rspec_opts = %w[--color --format=documentation]
  task.pattern = Dir['spec/**/*_spec.rb']
end
 
task :default => ['specs']
