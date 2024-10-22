source "https://rubygems.org"

ruby "3.3.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.0.rc1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails", "~> 3.4.2"

# Use sqlite3 as the database for Active Record [https://github.com/sparklemotion/sqlite3-ruby]
gem "sqlite3", "~> 2.1.0"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.4.3"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails", "~> 2.0.3"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "~> 2.0.11"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.3.4"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "~> 2.13.0"

# Use Redis adapter to run Action Cable in production [https://github.com/redis/redis-rb]
# gem "redis", "~> 5.1.0"

# Adapter for background jobs [https://github.com/sidekiq/sidekiq]
gem "sidekiq", "~> 7.2.2"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.13"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ jruby ] # windows

# Reduces boot times through caching; required in config/boot.rb [https://github.com/shopify/bootsnap]
gem "bootsnap", "~> 1.18.4", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Rubyzip is a ruby library for reading and writing zip files [https://github.com/rubyzip/rubyzip]
gem "rubyzip", "~> 2.3.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri ] # windows
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Ruby development tool server
  gem "ruby-lsp", require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
