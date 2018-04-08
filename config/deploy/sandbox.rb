# deploys to DCE sandbox
set :stage, :sandbox
set :rails_env, 'production'
set :deploy_to, '/opt/nurax'
server 'nurax.curationexperts.com', user: 'deploy', roles: [:web, :app, :db]
