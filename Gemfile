source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
# Jeweler Gems
ruby '2.5.1'

# gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# gem 'activestorage', github: 'rails/activestorage'
# gem 'platform-api' # Heroku
gem 'stripe'
gem 'omniauth-stripe-connect'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'github_api'
gem 'devise'
gem 'carrierwave', '~> 1.0'
gem 'cancancan', '~> 2.0'
gem 'json'
gem 'screencap'
gem 'simple_form' #TODO: Evaluate if we use this
gem 'font-awesome-rails'
gem 'redcarpet'
gem 'yaml_db'
gem 'jquery-ui-rails'
gem 'jquery-rails'
gem 'rails-ujs'
gem 'yui-compressor'
gem 'therubyracer' # Ruby
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'rollbar'
gem 'premailer-rails' #TODO: Implement Styled Mailers

# Refactoring / Service Objects / Patterns
# gem 'rails-patterns'
# gem 'business_process'
# gem 'virtus'

# TODO: Get Bootsnap working again (crashing)
# gem 'bootsnap', '>= 1.1.0', require: false
# gem 'bootsnap', require: false

# Memory Testing
gem 'skylight'

group :production do
  # gem 'memcache', '~> 1.5', '>= 1.5.1' #TODO: Why is Memcache gem disabled in Prod? We eventually want this.
  gem 'rails_12factor'
  gem 'uglifier', '>= 1.3.0'
  gem 'foreman'
end
group :development, :test do
  gem 'capybara-email'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
  gem 'dotenv-rails'
  gem 'capybara'
  gem 'better_errors'
  gem 'launchy'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # Call 'byebug' anywhere in the code to stop execution and get a debugger console
end
group :development do
  gem 'pry-rails'
  gem 'web-console', '>= 3.3.0' # Add to page: <%= console %>
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'binding_of_caller'
  # Memory
  gem 'rack-mini-profiler'
  # gem 'memory_profiler'
  # gem 'flamegraph'
  # gem 'stackprof'
  # gem 'derailed_benchmarks'
end
group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'minitest-reporters'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]