RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:suite) do
    FactoryGirl.reload
  end
  config.after(:suite) do
    FactoryGirl.factories.clear
  end
end
