# config valid only for current version of Capistrano
lock "3.8.0"

set :application, "potionstore"
set :repo_url, "ssh://git@miskatonic.krugerheavyindustries.com:7999/www/potionstore.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, "feature/khi"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/rails/potionstore"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml", "config/store.yml", "config/paypal.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
set :default_env, { path: "/home/deploy/.gem/ruby/2.3/bin:$PATH", RAILS_SERVE_STATIC_FILES: "true" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :puma_threads, [0, 4]
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "tcp://0.0.0.0:9295"
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_access_log, "#{shared_path}/log/puma.access.log"
set :puma_error_log, "#{shared_path}/log/puma.error.log"
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
