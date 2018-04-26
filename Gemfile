source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
# Jeweler Gems
ruby '2.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# Jeweler: gem 'rails', '~> 5.2.0.rc1'
# gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# gem 'activestorage', github: 'rails/activestorage'

gem 'platform-api' # Heroku
gem 'stripe'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'github_api'
# gem 'github_api'
# gem 'octokit', '~> 4.0'
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
# gem 'jquery-rails', '1.11.1'
gem 'jquery-ui-rails'
# gem 'jquery-rails'
gem 'rails-ujs'
gem 'sass-rails', '~> 5.0'
gem 'less-rails', '~> 3.0.0'
gem 'therubyracer' # Ruby
# gem 'mini_racer', platforms: :ruby
gem 'coffee-rails', '~> 4.2'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.5'
# gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'
# TODO: Install and configure Audited Gem
# gem 'audited', '~> 4.6'
# gem 'paper_trail'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rollbar'
gem 'colorize'
group :production do
  # gem 'memcache', '~> 1.5', '>= 1.5.1' #TODO: Why is Memcache gem disabled in Prod? Do we want this?
  gem 'rails_12factor'
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
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # Call 'byebug' anywhere in the code to stop execution and get a debugger console
end
group :development do
  gem 'pry-rails'
  gem 'web-console', '>= 3.3.0' # Add to page: <%= console %>
  # gem 'listen', '>= 3.0.5', '< 3.2' # TODO: Why was that here? Its depracated
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'binding_of_caller'
end
group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false, group: :test
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
