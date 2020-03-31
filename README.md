# released.today

[![Maintainability](https://api.codeclimate.com/v1/badges/34b834495f8ec12fcf44/maintainability)](https://codeclimate.com/github/matiasleidemer/released-today/maintainability)

Track new music releases from your favorite artists. Don't miss a thing! 🎶

## Setup

- Ruby 2.6.3
- Rails 5.2
- Postgres 9.6
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

#### Spotify

ReleasedToday uses Spotify to gather information about user's releases. To be able to access the user's account, you need to generate both the spotify_client_id and spotify_client_secret tokens.

To create those, you should visit [Spotify's developer page](https://developer.spotify.com/dashboard/applications) and create a new app. Once you finished all steps you should be able to get both the Client ID and Client Secret.

There's one extra step, however. You should add the Redirect URIs to your app. Once you're on your Spotify app's page, click the edit settings button and add the URIs:

- `http://localhost:3000/users/auth/spotify/callback` _(development)_
- `https://your-production-app.com/users/auth/spotify/callback` _(production)_

That's it, remember to update the `.env` file and you should be good to go.

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

Alternatively, you can use the `foreman` gem to orchestrate everything for you. Just make sure you have both Redis and Postgres running. It will start a server on port 3000:

```
bundle exec foreman start -f Procfile.development
```

## Tests

We use RSpec for our tests. You can run the full test suite with:

```
bundle exec rspec
```
