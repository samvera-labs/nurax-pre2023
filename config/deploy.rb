# config valid only for current version of Capistrano
lock "3.16.0"

set :application, "nurax"
set :repo_url, "https://github.com/curationexperts/nurax.git"
set :deploy_to, '/opt/nurax'
set :rails_env, 'production'
set :ssh_options, keys: ['nurax-dev-deploy_rsa'] if File.exist?('nurax-dev-deploy_rsa')

# Default branch is :main
set :branch, ENV['REVISION'] || ENV['BRANCH'] || ENV['BRANCH_NAME'] || 'main'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/analytics.yml"
# append :linked_files, "config/browse_everything_providers.yml"
append :linked_files, "config/database.yml"
append :linked_files, "config/secrets.yml"
append :linked_files, ".env.production"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# We have to re-define capistrano-sidekiq's tasks to work with
# systemctl in production. Note that you must clear the previously-defined
# tasks before re-defining them.
namespace :sidekiq do
  task :stop do
    on roles(:app) do
      execute :sudo, :systemctl, :stop, :sidekiq
    end
  end
  task :start do
    on roles(:app) do
      execute :sudo, :systemctl, :start, :sidekiq
    end
  end
  task :restart do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, :sidekiq
    end
  end
end

namespace :bundler do
  after :install, :update do
    on roles(:app) do
      within release_path do
        if (ENV['HYRAX_TARGET'] || 'main') == 'main'
          execute  :bundle, :config, :unset, :deployment
          execute  :bundle, :update, '--quiet', '--source', 'samvera/hyrax hyrax'
          execute  :bundle, :config, '--local', :set, :deployment, :true
        end
      end
    end
  end
end
# Capistrano passenger restart isn't working consistently,
# so restart apache2 after a successful deploy, to ensure
# changes are picked up.
namespace :deploy do
  after :finishing, :restart_apache do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, :apache2
    end
  end
end
