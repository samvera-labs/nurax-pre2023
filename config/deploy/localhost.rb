# For use in first ansible deploy
set :stage, :localhost
set :rails_env, 'production'
set :deploy_to, '/opt/nurax'
server '127.0.0.1', user: 'deploy', roles: [:web, :app, :db]
