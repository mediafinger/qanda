# frozen_string_literal: true

source "https://rubygems.org"

# To use https when pointing to github repos:
# git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# For heroku:
# ruby "2.7.2"

gem "rails", "~> 6.1"

gem "bootsnap", ">= 1.1.0", require: false
gem "dotenv-rails", "~> 2.4"
gem "haml-rails", "~> 2.0"
gem "jbuilder", "~> 2.5"
gem "omniauth-google-oauth2", "~>  1.0"
gem "omniauth-rails_csrf_protection", "~>  1.0"
gem "pg", ">= 0.18", "< 2.0"
gem "pg_search", "~> 2.1"
gem "puma", "~> 3.11"
gem "redcarpet", "~> 3.4"
gem "rouge", "~> 3.1"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "amazing_print", "~> 1.3"
  gem "bundler-audit", "~> 0.6"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 3.16"
  gem "factory_bot_rails", "~> 4.8"
  gem "rspec-rails", "~> 5.0"
  gem "rubocop", "0.79.0", require: false
  gem "rubocop-performance", "~> 1.5"
  gem "rubocop-rails", "~> 2.4"
  gem "rubocop-rspec", "~> 1.36"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
