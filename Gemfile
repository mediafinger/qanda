# frozen_string_literal: true

source "https://rubygems.org"

# To use https when pointing to github repos:
# git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# For heroku:
# ruby '2.5.0'

gem "rails", "~> 5.2.0"

gem "bootsnap", ">= 1.1.0", require: false
gem "dotenv-rails", "~> 2.4"
gem "haml", "~> 5.0"
gem "jbuilder", "~> 2.5"
gem "omniauth-google-oauth2", "~>  0.5.3" # Alternative with more starts on GitHub: # gem 'google-api-client', '~> 0.11'
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "redcarpet", "~> 3.4"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "awesome_print", "~> 1.8"
  gem "bundler-audit"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 3.7"
  gem "rubocop", "0.55.0", require: false
  gem "rubocop-rspec", "~> 1.25"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
