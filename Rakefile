require 'rake'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

# Unit Tests
RSpec::Core::RakeTask.new(:spec)

# Style Tests
namespace :style do
  require 'rubocop/rake_task'
  desc 'RuboCop'
  RuboCop::RakeTask.new(:ruby) do |task|
    task.options = ['--display-cop-names']
  end
end

desc 'Rubocop'
task default: %w(style:ruby)

desc 'Circle CI Tasks'
task circleci: %w(style:ruby)
