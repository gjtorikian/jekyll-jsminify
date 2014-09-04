require "bundler/gem_tasks"
require 'rspec'
require 'rspec/core/rake_task'

task :default => [:spec]

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.ruby_opts = %w[-w]
  t.rspec_opts = %w[--color]
end