require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'capybara/rails'
  require 'rspec/rails'
  require 'rspec/autorun'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  Capybara.default_wait_time = 3
  RSpec.configure do |config|
    config.mock_with :rspec
    config.include Capybara::DSL
    require 'database_cleaner'
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end
    config.before(:each) do
      DatabaseCleaner.clean
    end
    config.infer_base_class_for_anonymous_controllers = false
    #     --seed 1234
    config.order = "random"
    config.include FactoryGirl::Syntax::Methods
  end
end