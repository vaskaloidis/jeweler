# frozen_string_literal: true

# Jeweler Gems

source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.1'

# gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# gem 'activestorage', github: 'rails/activestorage'
# gem 'platform-api' # Heroku
gem 'cancancan', '~> 2.0'
gem 'carrierwave', '~> 1.0'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'font-awesome-rails'
gem 'github_api'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'json'
gem 'omniauth-stripe-connect'
gem 'pg'
gem 'premailer-rails' #TODO: Implement Styled Mailers
gem 'puma', '~> 3.11'
gem 'rails-ujs'
gem 'redcarpet'
gem 'rollbar'
gem 'screencap'
gem 'simple_form' #TODO: Evaluate if we use this
gem 'stripe'
gem 'therubyracer' # Ruby
gem 'time_for_a_boolean', '~> 0.2.0'
gem 'yaml_db'
gem 'yui-compressor'
# Move this to Dev group after initial seeding
gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'

# Refactoring / Service Objects / Patterns
gem 'rails-patterns'
# gem 'business_process'
gem 'virtus'

# TODO: Get Bootsnap working again (crashing)
# gem 'bootsnap', '>= 1.1.0', require: false
# gem 'bootsnap', require: false

# Memory Testing
# gem 'skylight'

gem 'jeweler-utils', path: '../jeweler-utils'
# gem 'jeweler-utils', git: 'https://github.com/vaskaloidis/jeweler-utils.git'

group :production do
  # gem 'memcache', '~> 1.5', '>= 1.5.1' #TODO: Why is Memcache gem disabled in Prod? We eventually want this.
  gem 'foreman'
  gem 'rails_12factor'
  gem 'uglifier', '>= 1.3.0'
end
group :test do
  gem 'minitest-spec-rails'
  gem 'minitest-around'
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'minitest-reporters'
  gem 'selenium-webdriver'
  gem 'shoulda', '~> 3.5'
  gem 'shoulda-matchers', '~> 2.0'
  gem 'simplecov'
  gem 'simplecov-console'
end
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'capybara-email'
  gem 'coveralls', require: false
  gem 'dotenv-rails'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'rubocop', '~> 0.56.0', require: false
end
group :development do
  gem 'guard'
  gem 'guard-minitest'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bundler-audit' # TODO: Security Audit Gems
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # Add to page: <%= console %>
  # Memory
  gem 'bullet'
  gem 'rack-mini-profiler'
  # gem 'memory_profiler'
  # gem 'flamegraph'
  # gem 'stackprof'
  # gem 'derailed_benchmarks'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]