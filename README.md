[![Build Status](https://travis-ci.org/curationexperts/nurax.svg?branch=master)](https://travis-ci.org/curationexperts/nurax)

# README
This is an application used for testing the state of [Hyrax](https://github.com/samvera/hyrax). The `master` branch is pinned to Hyrax
master, and is automatically deployed to [nurax-dev.curationexperts.com](https://nurax-dev.curationexperts.com) once per
day. The `nurax-stable` branch is pinned to the latest stable release of Hyrax,
and is deployed much less often, only when there has been a new release, to
[nurax-stable.curationexperts.com](https://nurax-stable.curationexperts.com).

## Infrastructure
The nurax servers are built using the [ansible-samvera](https://github.com/curationexperts/ansible-samvera) ansible roles. These servers are maintained by Data Curation Experts as a service to [the Samvera Community](http://samvera.org).

## Auto-deploy process
The method we use to auto-deploy is documented in [the DCE Playbook](https://curationexperts.github.io/playbook/production/continuous_deployment.html). Auto-deploy to `samvera-dev` will happen upon a successful travis build of the `nurax` codebase. This happens whenever a PR is merged to master, and is triggered by travis once per day if no PR is submitted that day. Eventually we would like to have this code deploy every time a successful PR is made to Hyrax.

## Questions
Please direct questions about this code or the servers where it runs to the `#nurax` channel on Samvera slack.
