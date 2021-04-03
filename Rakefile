# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

if %w(development test).include? Rails.env
  require "amazing_print"
  require "bundler/audit/task"
  require "haml_lint/rake_task"
  require "rspec/core/rake_task"
  require "rubocop/rake_task"
  require "scss_lint/rake_task"

  # setup task bundle:audit
  Bundler::Audit::Task.new

  # setup task haml_lint
  HamlLint::RakeTask.new

  # setup task rspec
  RSpec::Core::RakeTask.new(:rspec)

  # setup taks rubocop and rubocop:auto_correct
  RuboCop::RakeTask.new

  # setup task scss_lint
  SCSSLint::RakeTask.new(:scss_lint) do |t|
    t.files = Dir.glob(["app/assets/stylesheets"])
  end

  namespace :factory_bot do
    desc "Verify that all FactoryBot factories are valid"
    task lint: :environment do
      puts "Building all factories and traits to ensure they are valid"
      FactoryBot.lint traits: true, strategy: :build, verbose: true
    end
  end

  desc "Run rubocop and the specs"
  task ci: %w(rubocop factory_bot:lint rspec bundle:audit)
end
