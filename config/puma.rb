# Puma configuration for Render

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

environment ENV.fetch("RAILS_ENV") { "production" }

# Only set the port; Render will route traffic correctly
port ENV.fetch("PORT") { 10000 }

# Workers for concurrency (optional)
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!

# Allow puma to be restarted by `bin/rails restart`
plugin :tmp_restart

# Solid Queue plugin (if using)
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# PID file (optional)
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
