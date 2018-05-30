# rake Jeweler:test

namespace :Jeweler do

  desc 'Run Tests Verbose w/ Backtrace'
  task test_loud: :environment do

    puts 'Testing Verbose w/ Backtrace'
    Rake::Task["test TESTOPTS='-vb'"].invoke
  end

  desc 'Run Tests Verbose'
  task test: :environment do
    puts 'Testing Verbose'
    Rake::Task["test TESTOPTS='-v'"].invoke
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
