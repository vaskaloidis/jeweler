source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
# Jeweler Gems
ruby '2.5.0'

# gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0rc2'
# gem 'activestorage', github: 'rails/activestorage'
# gem 'platform-api' # Heroku
gem 'stripe'
gem 'omniauth-stripe-connect'
gem 'pg'
gem 'puma', '~> 3.11'
# gem 'github_api'
gem 'devise'
gem 'carrierwave', '~> 1.0'
gem 'rolify'
gem 'cancancan', '~> 2.0'
gem 'json'
gem 'screencap'
gem 'simple_form'
gem 'font-awesome-rails'
gem 'redcarpet'
gem 'yaml_db'
gem 'jquery-ui-rails'
gem 'jquery-rails'
gem 'rails-ujs'
# gem 'sass-rails', '~> 5.0'
# gem 'sass-rails', '~> 3.2.3'
gem 'yui-compressor'
gem 'therubyracer' # Ruby
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
# gem 'bcrypt', '~> 3.1.7'
# gem 'audited', '~> 4.6' # TODO: Install and configure Audited Gem
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rollbar'
gem 'colorize'
group :production do
  # gem 'memcache', '~> 1.5', '>= 1.5.1' #TODO: Why is Memcache gem disabled in Prod? We eventually want this.
  gem 'rails_12factor'
  gem 'foreman'
  gem 'uglifier', '>= 1.3.0'
end
group :development, :test do
  gem 'dotenv-rails'
  gem 'faker'
  gem 'capybara'
  # gem 'awesome_print' #TODO: Use this one day
  gem 'better_errors'
  gem 'launchy'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # Call 'byebug' anywhere in the code to stop execution and get a debugger console
end
group :development do
  gem 'derailed_benchmarks'
  gem 'pry-rails'
  gem 'web-console', '>= 3.3.0' # Add to page: <%= console %>
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'binding_of_caller'
end
group :test do
  # gem 'rspec'
  # gem 'rspec-rails', '~> 3.7'
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false, group: :test
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]