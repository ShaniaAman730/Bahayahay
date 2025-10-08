# Puma configuration for Render

threads_count = ENV.fetch("RAILS_MAX_THREADS", 5).to_i
threads threads_count, threads_count

environment ENV.fetch("RAILS_ENV", "production")

# Render automatically sets PORT, default fallback 10000
port ENV.fetch("PORT", 10000)

# Workers for concurrency
workers ENV.fetch("WEB_CONCURRENCY", 2).to_i
preload_app!

# Allow Puma to be restarted by `bin/rails restart`
plugin :tmp_restart

# Solid Queue plugin (if using)
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# PID file (optional)
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]

# On Render, bind to all interfaces (0.0.0.0)
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 10000)}"
