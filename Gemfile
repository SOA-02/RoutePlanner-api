# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

# Configuration and Utilities
gem 'figaro', '~> 1.2'
gem 'pry'
gem 'rack-test' # for testing and can also be used to diagnose in production
gem 'rake'

# PRESENTATION LAYER
gem 'multi_json', '~> 1.15'
gem 'roar', '~> 1.1'

# Web Application
gem 'logger', '~> 1.6'
gem 'puma', '~> 6.4'
gem 'rack-session', '~> 0.3'
gem 'roda', '~> 3.85'


# Controllers and services
gem 'dry-monads', '~> 1.4'
gem 'dry-transaction', '~> 0.13'
gem 'dry-validation', '~> 1.7'

# Validation
gem 'dry-struct', '~> 1.6'
gem 'dry-types', '~> 1.7'


# Networking
gem 'http', '~> 5.2'

# Database
gem 'hirb'
gem 'sequel', '~> 5.60'

group :development, :test do
  gem 'sqlite3', '~> 1.4'
end

group :production do
  gem 'pg'
end

# Testing
group :test do
  gem 'minitest', '~> 5.20'
  gem 'minitest-rg', '~> 5.2'
  gem 'simplecov', '~> 0'
  gem 'vcr', '~> 6'
  gem 'webmock', '~> 3'
end

# Development
group :development do
  gem 'flog'
  gem 'reek'
  gem 'rerun'
  gem 'rubocop'
  gem 'rubocop-minitest'
  gem 'rubocop-rake'
  gem 'rubocop-sequel'
end

# Gemfile
gem 'fiddle'
gem 'rdoc'
