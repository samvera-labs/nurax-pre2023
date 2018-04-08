# deploys to DCE sandbox
set :stage, :travis
set :rails_env, 'production'
set :deploy_to, '/opt/nurax'
server 'nurax.curationexperts.com', user: 'deploy', roles: [:web, :app, :db]
set :ssh_options, keys: ['config/nurax-travis']
