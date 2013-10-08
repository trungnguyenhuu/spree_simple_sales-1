require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'
require 'rspec/core/rake_task'
require 'spree/core/testing_support/common_rake'

RSpec::Core::RakeTask.new

task :default => [:spec]

spec = eval(File.read('spree_simple_sales.gemspec'))

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end

desc "Generates a dummy app for testing"
task :test_app do
  # need spree_auth_devise for test to pass
  # https://github.com/spree/spree/issues/1862
  ENV['LIB_NAME'] = 'spree_simple_sales'
  Rake::Task['common:test_app'].invoke 'Spree::User'
end
