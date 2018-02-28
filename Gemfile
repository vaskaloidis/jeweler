source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.4'
gem 'rails', '~> 5.2.0.rc1'

gem 'pg'
gem 'puma', '~> 3.11'

gem 'devise'
gem 'carrierwave', '~> 1.0'
gem 'rolify'
gem 'cancancan', '~> 2.0'

gem 'paper_trail'

# gem 'dotenv-rails', :groups => [:development, :test]
gem 'yaml_db'

# gem 'jquery-rails', '1.11.1'
# gem 'jquery-ui-rails'
# gem 'jquery-rails'

gem 'sass-rails', '~> 5.0'
gem 'less-rails', '~> 3.0.0'
gem 'therubyracer' # Ruby
# gem 'mini_racer', platforms: :ruby
gem 'coffee-rails', '~> 4.2'
gem 'uglifier', '>= 1.3.0'

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# gem 'audited', "~> 4.6" #TODO: Install and configure Audited Gem

# gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'

# gem 'mini_magick', '~> 4.8'
# gem 'capistrano-rails', group: :development

gem 'bootsnap', '>= 1.1.0', require: false

group :production do
  # gem "memcache", "~> 1.5", ">= 1.5.1"
  gem 'rollbar'
  gem 'foreman'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'faker'
  gem 'rspec'
  gem 'rspec-rails', '~> 3.7'
  gem 'capybara'
  gem 'awesome_print'
  gem 'better_errors'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  # gem 'web-console' # Add to page: <%= console %>
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # Call 'byebug' anywhere in the code to stop execution and get a debugger console
end

group :development do
  gem 'pry-rails'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false, group: :test
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
