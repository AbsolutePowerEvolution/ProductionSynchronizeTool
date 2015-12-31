require_relative 'lib/git'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  task :spec do
    STDERR.puts 'Install rspec to run spec task'
  end
end

task :check do
  git = Git.new
  modify = git.repo_modify
  unless modify.empty?
    puts 'These file has been modify. This may cause sync fail'
    puts '----------------------------------------------------'
    puts modify.join("\n")
    puts
    fail 'Check fail'
  end
  begin
    git.remote_check
  rescue ProductionSync::GitError => e
    puts e.message
    raise 'Check fail'
  end
end

task default: :spec
