# rake Jeweler:test

namespace :jeweler do

  desc 'Run Tests Verbose w/ Backtrace'
  task test_loud: :environment do
    puts 'Testing Verbose w/ Backtrace'
    ENV['TESTOPTS'] = '-vb'
    Rake::Task["test"].invoke
  end

  desc 'Run Tests Verbose'
  task test: :environment do
    puts 'Testing Verbose'
    Rake::Task["log:clear"].invoke
    ENV['TESTOPTS'] = '-v'
    ENV['RAKE_ENV'] = 'test'
    ENV['RAILS_ENV'] = 'test'
    Rake::Task["test"].invoke
  end

  desc 'Info'
  task info: :environment do
    Bundler.with_clean_env do
      sh 'rails --help | grep Jeweler: '
    end
    # Bundler.with_clean_env do
    # sh "rails --help | grep db: "
    # end
  end

  private

  def run(cmd)
    Bundler.with_clean_env do
      sh cmd.to_s
    end
  end

  def rake(cmd)
    Bundler.with_clean_env do
      sh 'rake ' + cmd.to_s
    end
  end

end
