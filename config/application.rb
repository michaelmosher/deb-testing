require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Rails.logger = Logger.new(STDOUT)

module Vagrant
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.cache_store = :file_store, "#{ENV.fetch("RAILS_DATA_ROOT", ".")}/tmp/cache"
    config.secret_key_base = ENV["SECRET_KEY_BASE"]
  end
end
