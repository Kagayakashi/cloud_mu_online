ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module AuthHelpers
  def start_new_session_for(user)
    post session_path, params: {
      email: user.email,
      password: "password"
    }

    Current.session = user.sessions.last
  end
end

module ActiveSupport
  class TestCase
    include AuthHelpers

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Setup fixtures in order
    # fixtures :users, :professions, :maps, :characters, :monster_types, :monsters

    # Add more helper methods to be used by all tests here...
  end
end
