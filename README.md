# released

Track new music releases from your favorite artists. Don't miss a thing! 🎶

## Setup

- Ruby 2.4.1
- Rails 5.1
- Postgres 9.2
- Redis
- Sidekiq

Once you downloaded the repo, install everything with 

```
bundle install
```

### Database

You can change your local Postgres connection configuration in `config/database.yml`.

Make sure you have Postgres up and running and setup your local database:

```
./bin/rails db:create:all db:migrate db:test:prepare
```

### Environment variables

We use a couple of environment variables in our system. For development purposes you should simply copy the example available in the repo:

```
cp .env.example .env
```

This will generate the required `.env` file.

### Sidekiq

You don't have to, but if you want to run Sidekiq in your development environment, you have to have redis up and running with the default settings:

In order to start sidekiq you should run:

```
bundle exec sidekiq -C config/sidekiq.yml
```

You can access sidekiq dashboard in the `/sidekiq` endpoint. Remember, however, your user needs to be logged in and also be an administrator.

### Starting the server

You can start the rails server by running:

```
./bin/rails server
```

Make sure you have Postgres running. The app should be running on `http://localhost:3000`.

### Foreman

Finally, you can use the `foreman` gem to orchestrate everything for you. Just make sure you have both Redis and Postgres running. It will start a server on port 5000:

```
bundle exec foreman start -f Procfile.development
```

## Deploys

Our app is hosted on Heroku. Make sure you have access to both instances (staging and production). If you don't have, ask the system administrator.

First, you're gonna need to setup both remotes:

```
git remote add staging https://git.heroku.com/released-staging.git
git remote add production https://git.heroku.com/released-production.git
```

This will allow you to deploy new versions. In order to do so, you should run:

```
./bin/deploy (production | staging)
```

**Please be aware when deploying production.**

## Database dumps

With the Heroku remotes properly configured, you can download a production or staging db dump:

```
./bin/dump_db (production | staging)
```

Remember that the production dump can take a while to download. You should be good to go with a staging dump.

## Tests

We use RSpec for our tests. You can run the full test suite with: 

```
bundle exec rspec
```
