require 'jeweler_rake_commands'

# Usage: rake Jeweler:test
namespace :jeweler do
  include JewelerRakeCommands
  task default: [:test]

  desc 'Uninstall All GitHub Webhooks'
  task purge_hooks: :environment do
    Project.each do |project|
        if project.github.webhook.installed?
          project.github.webhook.uninstall!
        end
    end
  end

  desc 'Test current feature'
  task feature_test: :environment do
    JewelerRakeCommands.clear_logs
    run('clear')
    JewelerRakeCommands.test('models/git_hub_app')
    JewelerRakeCommands.test('models/git_hub_oauth')
    # JewelerRakeCommands.test('controllers/github_controller')
  end

  desc 'Simple Quick Minitest Suite (Default Tests)'
  task quick_test: :environment do
    JewelerRakeCommands.clear_logs
    JewelerRakeCommands.default_tests
  end

  desc 'Normal Test Suite: Factory Bot Lint, Minitest, Capybara System Tests'
  task :test do
    JewelerRakeCommands.clear_logs
    JewelerRakeCommands.default_tests
    # JewelerRakeCommands.system_tests
  end

  desc 'Full Test Suite: Factory-Bot, Minitest, Capybara-System and Coverage'
  task full_test: :environment do
    JewelerRakeCommands.clear_logs
    # JewelerRakeCommands.factory_bot_tests
    JewelerRakeCommands.default_tests
    JewelerRakeCommands.system_tests
  end

  desc 'Run Default Minitest Tests Verbose w/ Backtrace'
  task debug_test: :environment do
    puts 'Executing "Rake Test" w/ Verbose + Backtrace Flag + Coverage'
    run("rake test TESTOPTS='-vb'")
  end

  desc 'Run a RubyCritic Test:'
  task critic_test: :environment do
    require "rubycritic/rake_task"
    RubyCritic.RakeTask.new do |task|
      # task.name    = 'critic_test'
      # task.options = '--no-browser'
      task.verbose = true
    end
    JewelerRakeCommands.rake('rubycritic')
  end

  desc 'Test FactoryBot Factories are Valid (lint test)'
  task factory_test: :environment do
    JewelerRakeCommands.factory_bot_tests
  end

  desc 'Test Jeweler-Utils Gem'
  task utils_test: :environment do
    run('cd ../jeweler-utils/')
    run('bin/test')
  end

  desc 'Info'
  task info: :environment do
    run 'rails --help | grep jeweler'
  end

  def run(cmd)
    Bundler.with_clean_env do
      puts cmd
      sh cmd.to_s
    end
  end

end
