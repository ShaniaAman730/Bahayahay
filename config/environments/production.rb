require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false

  # Caching
  config.action_controller.perform_caching = true
  config.cache_store = :solid_cache_store
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Assets
  config.assets.compile = true
  config.public_file_server.enabled = true

  # Force SSL
  config.force_ssl = true
  config.assume_ssl = true

  # Logging
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Active Job
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  # Active Storage
  # Use cloud storage in production; local is temporary
  config.active_storage.service = :local

  # Action Cable
  # config.action_cable.url = "wss://bahayahay.onrender.com/cable"
  # config.action_cable.allowed_request_origins = ['https://bahayahay.onrender.com']

  # Without Action Cable
  config.action_cable.mount_path = nil
  config.action_cable.allowed_request_origins = []

  # Mailer
  config.action_mailer.default_url_options = { host: "bahayahay.onrender.com", protocol: "https" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'bahayahay.onrender.com',
    user_name:            ENV['SMTP_USERNAME'],
    password:             ENV['SMTP_PASSWORD'],
    authentication:       'plain',
    enable_starttls_auto: true
  }

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  # Cloudinary (active storage)
  config.active_storage.service = :cloudinary

  # I18n fallback
  config.i18n.fallbacks = true

  # Schema dump
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [:id]
end
