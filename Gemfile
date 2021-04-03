# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# For heroku:
# ruby "3.0.0"

# NOTE: update to "7.0.0" when it was released
# rails_version = "7.0.0.alpha" # rails master
gem "actionpack", github: "rails/rails" # , "~> #{rails_version}"
gem "activemodel", github: "rails/rails" # , "~> #{rails_version}"
gem "activerecord", github: "rails/rails" # , "~> #{rails_version}"
gem "railties", github: "rails/rails" # , "~> #{rails_version}"

gem "bootsnap", ">= 1.1.0", require: false
gem "dotenv-rails", "~> 2.4"
gem "haml-rails", "~> 2.0"
gem "jbuilder", "~> 2.5"
gem "omniauth-google-oauth2", "~>  1.0"
gem "omniauth-rails_csrf_protection", "~>  1.0"
gem "pg", ">= 0.18", "< 2.0"
gem "pg_search", "~> 2.1"
gem "puma", "~> 5.2"
gem "redcarpet", "~> 3.4"
gem "rouge", "~> 3.1"
gem "sass-rails", "~> 6.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "amazing_print", "~> 1.3"
  gem "bundler-audit", "~> 0.8"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 3.16"
  gem "factory_bot_rails", "~> 6.1"
  gem "haml_lint", "~> 0.37", require: false
  gem "rspec-rails", "~> 5.0"
  gem "rubocop", "1.12.0", require: false
  gem "rubocop-performance", "~> 1.10"
  gem "rubocop-rails", "~> 2.9"
  gem "rubocop-rake", "~> 0.5"
  gem "rubocop-rspec", "~> 2.2"
  gem "scss_lint", "~> 0.59", require: false
end

group :development do
  gem "listen", "~> 3.5"
  gem "web-console", ">= 3.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
