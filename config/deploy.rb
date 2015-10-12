# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'openhq.io'
set :repo_url, 'git@github.com:openhq/website.git'
set :deploy_to, '/var/www/openhq.io'
set :log_level, :info
set :linked_files, %w(.env)
set :linked_dirs, %w(log tmp/uploads)
set :migration_role, :app
set :rbenv_type, :user
set :rbenv_ruby, '2.2.2'
set :keep_releases, 3
set :passenger_restart_with_sudo, true

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
