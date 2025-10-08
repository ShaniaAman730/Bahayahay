# Puma configuration for Render

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Bind to 0.0.0.0 and the port Render provides
port        ENV.fetch("PORT") { 10000 }
bind        "tcp://0.0.0.0:#{ENV.fetch("PORT") { 10000 }}"

environment ENV.fetch("RAILS_ENV") { "production" }

# Workers for concurrency (optional, adjust based on your plan)
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Solid Queue plugin (only if using Solid Queue in Puma)
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# PID file (optional)
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
