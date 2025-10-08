require_relative "boot"
require "rails/all"
require "active_storage/engine"
require "image_processing/mini_magick"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bahayahay
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    config.eager_load_paths << Rails.root.join("app/validators")
    config.eager_load_paths << Rails.root.join("test/mailers/previews")

    
    config.solid_queue.connects_to = { database: { writing: :primary, reading: :primary } }

  end
end
