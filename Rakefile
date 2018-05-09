# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

require "awesome_print"
require "rspec/core"
require "rspec/core/rake_task"
require "rubocop"

Rails.application.load_tasks

RSpec::Core::RakeTask.new(:rspec)

task :environment do
  ENV["RACK_ENV"] ||= "development"
end

desc "Run rubocop with autocorrect"
task rubocop: :environment do
  puts "Obey the autocorrection cop!"
  sh "bundle exec rubocop -c .rubocop.yml --auto-correct"
end

namespace :rubocop do
  desc "Run rubocop without autocorrect"
  task not_correcting: :environment do
    sh "bundle exec rubocop -c .rubocop.yml"
  end
end

desc "Run rubocop and the specs"
task :test do
  ENV["RACK_ENV"] = "test"
  Rake::Task["rubocop:not_correcting"].invoke
  Rake::Task["rspec"].invoke
end

task default: :test
