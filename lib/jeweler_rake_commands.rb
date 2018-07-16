require 'rake'
require 'rake/tasklib'


# Various Jeweler Rake Commands for use in the Rake Tasks
module JewelerRakeCommands
  include FileUtils

  def clear_logs
    set_env
    Rake::Task["log:clear"].invoke
  end

  def system_tests
    set_env
    puts 'Executing Capybara System Tests'
    run 'rake test:system'
  end

  def default_tests
    set_env
    puts 'Executing  Minitest Test Suite ("Rake Test")'
    # Rake::Task["test"].invoke
    run 'rake test'
  end

  def factory_bot_tests
    set_env
    if Rails.env.test?
      puts 'Executing FactoryBot.lint test'
      DatabaseCleaner.cleaning do
        FactoryBot.lint
      end
    else
      system("bundle exec rake factory_bot:lint RAILS_ENV='test'")
      raise if $?.exitstatus.nonzero?
    end
  end

  def run2(cmd)
    Bundler.with_clean_env do
      sh cmd.to_s
    end
  end

  def run(cmd)
    require 'open3'
    Open3.popen3(cmd.to_s) do |stdout, stderr, status, thread|
      while line = stderr.gets do
        puts(line)
      end
    end
  end

  def rake(cmd)
    run("rake #{cmd}")
  end

  def test(test)
    test = "test/#{test}" unless test.starts_with?('test/')
    test = "#{test}_test.rb" unless test.ends_with?('_test.rb')
    run("rails test #{test}")
  end

  private

  def set_env
    ENV['JEWELER_RAKE_TASK'] = 'true'
  end

end