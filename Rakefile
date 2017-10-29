# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'rake/testtask'
Rake::TestTask.new do |i|
  i.test_files = FileList['test/test_*.rb']
  i.verbose = true
end

Rails.application.load_tasks
