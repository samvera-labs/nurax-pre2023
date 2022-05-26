namespace :cd do
  desc "Continuous deployment to Nurax environments"
  task :nurax_dev_deploy do
    STDOUT.sync=true
    # NOTE: If you run this job locally, at the end of it you will be on the main branch of the repo
    # Get the latest nurax main
    # Make a branch with today's date and update hyrax
    # Push and deploy that branch
    # Delete the branch

    today = Time.now.strftime('%Y-%m-%e-%H-%M')
    `git checkout main; git pull; git checkout -b "#{today}"`
    system('bundle update hyrax')
    `git config user.email "cd@curationexperts.com" && git config user.name "circleci"`
    `git commit -a -m 'Daily update for "#{today}"'; git push --set-upstream origin #{today}`
    `BRANCH_NAME="#{today}" cap nurax-dev deploy`
    `git checkout main; git push origin --delete "#{today}"`
    `git checkout main; git branch -D "#{today}"`
  end
end
