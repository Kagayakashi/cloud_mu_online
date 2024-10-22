# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

require 'active_support/security_utils'
require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = { size: 1 }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  # Protect against timing attacks:
  # - See https://codahale.com/a-lesson-in-timing-attacks/
  # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
  # - Use & (do not use &&) so that it doesn't short circuit.
  # - Use digests to stop length information leaking
  ActiveSupport::SecurityUtils.secure_compare(user, ENV["SIDEKIQ_USERNAME"]) &
    ActiveSupport::SecurityUtils.secure_compare(password, ENV["SIDEKIQ_PASSWORD"])
end

run Rails.application
Rails.application.load_server
