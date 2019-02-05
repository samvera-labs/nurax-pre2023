# Running Nurax with Docker

## Requirements

The details provided assume that the official Docker daemon is running in the background. Download and install Docker Community Edition from https://www.docker.com/community-edition, and `docker-compose` from https://docs.docker.com/compose/install/.

## Docker notes

- `$ docker system prune` : A command that will reclaim disk space by deleting stopped containers, networks, dangling images and build cache.
- `$ docker volume ls` : Show a list of named volumes which hold persistent data for containers.
- `$ docker volume rm [VOLUME NAME]` : Remove a named volume, to force the system to rebuild and start that services persistent data from scratch.

## Docker Compose basics

### Build the base application container

**Important:** Rebuilding the docker container is required whenever Gemfile or Dockerfile updates affect the application.

`$ docker-compose build`

# Development workflow

All of the required services are pre-configured with environment variables injected to the containers during boot. The database, repository, solr index, and redis queue are backed by persistent volumes to maintain data between use.

Start the development server:

    docker-compose up server
    (or, detached)
    docker-compose up -d server

_Open another terminal window (unless you run the previous command `detached`)._

On the first time building and starting the server, Hyrax defaults must be created and loaded. Run the commands on the server container.

    docker-compose run server bash
    ... wait for a shell session to start ...
    bundle exec rails hyrax:default_admin_set:create
    bundle exec rails hyrax:default_collection_types:create
    bundle exec rails hyrax:workflow:load

Visit http://localhost:3000/users/sign_up?locale=en to register an account.

### Making edits to application code

_Docker has mounted the Nurax code directory inside the container at `/data`, edits made directly to these files are reflected within the running container. As is the case with some application code, an application restart might be necessary for the system to reflect those changes._

Make yourself an admin user by adding the registered email address to the `admin` users in `config/role_map.yml`, then restart the server.

    docker-compose down
    ... wait for the services to stop ...
    docker-compose up server

Login to the app, and continue configuration or depositing works using the Hyrax UI.

# Testing workflow

Testing the application amounts to running all of the required services along side an instance of the application and then running the testing framework against those containers. All of the `*-test` services have applicable environment variables injected to the containers during boot.

Start the test server:

    docker-compose up test
    (or, detached)
    docker-compose up -d test

_Open another terminal window (unless you run the previous command `detached`)_

Start a session, and run `rspec` on the test (application) container. _(This method offers a more developer/TDD friendly experience)_

    docker-compose run test bash
    ... wait for a shell session to start ...
    bundle exec rspec

**OR** run `rspec` on the test (application) container directly:

    docker-compose run test rspec
