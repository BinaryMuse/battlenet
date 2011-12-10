require 'bundler'
require 'rspec/core/rake_task'

task :default => :spec
task :test => :spec

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--color', '-f progress', '-r ./spec/spec_helper.rb']
  t.pattern = 'spec/**/*_spec.rb'
  t.fail_on_error = true
end
