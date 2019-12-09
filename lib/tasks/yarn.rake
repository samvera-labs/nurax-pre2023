namespace :yarn do
  desc "Install all JavaScript dependencies as specified via Yarn"
  task :install do
    system("yarn install --no-progress --production")
  end
end
