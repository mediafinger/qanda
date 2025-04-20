# frozen_string_literal: true

source "https://rubygems.org"

# To use https when pointing to github repos:
# git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# For heroku:
# ruby File.read(".ruby-version").strip.delete_prefix("ruby-")

gem "rails", "~> 7.0"

# gems that were removed from Ruby's standard library
# listing them here will be redundant, once the rails version is updated
gem "base64"
gem "benchmark"
gem "bigdecimal"
gem "matrix"
gem "mutex_m"
gem "observer"
gem "ostruct"

gem "sprockets-rails", require: "sprockets/railtie"

# gem "bootsnap", ">= 1.1.0", require: false
gem "dartsass-rails"
gem "dotenv-rails", "~> 3.0"
gem "haml-rails", "~> 2.0"
gem "jbuilder", "~> 2.5"
gem "omniauth-google-oauth2", "~>  1.1"
gem "omniauth-rails_csrf_protection", "~>  1.0"
gem "pg", ">= 0.18", "< 2.0"
gem "pg_search", "~> 2.1"
gem "puma", "~> 6.4"
gem "redcarpet", "~> 3.4"
gem "rouge", "~> 4.0"
# gem "sass-rails", "~> 6.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "amazing_print", "~> 1.3"
  gem "bundler-audit", "~> 0.9"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 3.40"
  gem "factory_bot_rails", "~> 6.1"
  gem "haml_lint", "~> 0.37", require: false
  gem "rspec-rails", "~> 7.0"
  gem "rubocop", "~> 1.65", require: false
  gem "rubocop-capybara"
  gem "rubocop-factory_bot"
  gem "rubocop-faker"
  gem "rubocop-performance"
  gem "rubocop-rails", "~> 2.25"
  gem "rubocop-rake"
  gem "rubocop-rspec"
  gem "rubocop-rspec_rails"
  gem "scss_lint", "~> 0.59", require: false
end

group :development do
  gem "listen", "~> 3.5"
  gem "web-console", ">= 3.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
