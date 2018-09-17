require 'database_cleaner'

DatabaseCleaner.clean_with :truncation

DatabaseCleaner.strategy = :transaction

# with the minitest-around gem, this may be used instead:
class Minitest::Spec
  around do |tests|
    DatabaseCleaner.cleaning(&tests)
  end
end