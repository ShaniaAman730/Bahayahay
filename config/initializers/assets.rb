# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Precompile custom stylesheets
Rails.application.config.assets.precompile += %w( style.css )

# You typically don't need to precompile JavaScript if using Importmap or Webpacker
# Remove these unless you're using Sprockets to serve JS manually
# If needed, you can re-add specific legacy scripts here

Rails.application.config.assets.precompile += %w( @hotwired--turbo.js )
Rails.application.config.assets.precompile += %w( @rails--actioncable--src.js )
Rails.application.config.assets.precompile += %w( @hotwired--turbo-rails.js )
Rails.application.config.assets.precompile += %w( controllers/hello_importmap.js )
Rails.application.config.assets.precompile += %w( jquery.js )
Rails.application.config.assets.precompile += %w( @rails--ujs.js )
Rails.application.config.assets.precompile += %w( controllers/@hotwired/stimulus-loading.js )
Rails.application.config.assets.precompile += %w( controllers/hello_controller.js )
Rails.application.config.assets.precompile += %w( controllers/index.js )
