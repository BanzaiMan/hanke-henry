require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'rdoc/task'

task :default => [:spec]

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--color']
end

desc 'Generate documentation with RDoc'
RDoc::Task.new do |rdoc|  
  rdoc.rdoc_files.include("lib/**/hanke*.rb")
end