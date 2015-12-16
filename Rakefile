begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  task :spec do
    STDERR.puts 'Install rspec to run spec task'
  end
end

task default: :spec
