# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

if %w(development test).include? Rails.env
  require "awesome_print"
  require "bundler/audit/task"
  require "rspec/core/rake_task"
  require "rubocop"

  RSpec::Core::RakeTask.new(:rspec)

  desc "Check for CVEs"
  task bundle_audit: :environment do
    sh "bundle exec bundle audit update"
    sh "bundle exec bundle audit check --ignore CVE-2015-9284" # OmniAuth CVE, fixed with gem omniauth-rails_csrf_protection
  end

  desc "Run rubocop"
  task rubocop: :environment do
    sh "bundle exec rubocop -c .rubocop.yml"
  end

  desc "Run rubocop with autocorrect"
  task rubocopa: :environment do
    puts "Obey the autocorrection cop!"
    sh "bundle exec rubocop -c .rubocop.yml --auto-correct"
  end

  desc "Run rubocop and the specs"
  task ci: %w(rubocop rspec bundle_audit)
end
