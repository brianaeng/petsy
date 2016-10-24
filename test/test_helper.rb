ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require "simplecov"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  Minitest::Reporters.use!
  # Add more helper methods to be used by all tests here...
  SimpleCov.start

  def setup
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({provider: 'github', uid: '123545', info: {email: "a@b.com", name: "Ada"}, extra: {raw_info: {avatar_url: "image.jpg"}}})
  end
end
