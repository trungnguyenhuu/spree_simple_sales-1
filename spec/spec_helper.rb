ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'ffaker'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require 'spree/core/testing_support/factories'
# require 'spree/core/testing_support/env'
require 'spree/core/testing_support/controller_requests'
require 'spree/core/url_helpers'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods
  config.include Spree::Core::TestingSupport::ControllerRequests
  config.include Spree::Core::UrlHelpers
end
