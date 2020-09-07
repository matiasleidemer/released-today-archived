[![Build Status](https://travis-ci.com/matiasleidemer/released-today.svg?branch=master)](https://travis-ci.com/matiasleidemer/released-today)
[![Maintainability](https://api.codeclimate.com/v1/badges/34b834495f8ec12fcf44/maintainability)](https://codeclimate.com/github/matiasleidemer/released-today/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/34b834495f8ec12fcf44/test_coverage)](https://codeclimate.com/github/matiasleidemer/released-today/test_coverage)

# released.today

Released Today leverages the Spotify api to fetch your top artists new releases.

Don't miss a thing! 🎶

## Setup

### Spotify

ReleasedToday uses Spotify to gather information about user's releases. To be able to access the user's account, you need to generate both the spotify_client_id and spotify_client_secret tokens.

To create those, you should visit [Spotify's developer page](https://developer.spotify.com/dashboard/applications) and create a new app. Once you finished all steps you should be able to get both the Client ID and Client Secret.

There's one extra step, however. You should add the Redirect URIs to your app. Once you're on your Spotify app's page, click the edit settings button and add the URIs:

- `http://localhost:3000/users/auth/spotify/callback` _(development)_
- `https://your-production-app.com/users/auth/spotify/callback` _(production)_

### Environment variables

Generate the required `.env` file by running the following:

```
cp .env.example .env
```

Remember to update both the `SPOTIFY_CLIENT_ID` and `SPOTIFY_CLIENT_SECRET` variables from the step
above.

### Docker

Released today uses Docker and docker-compose, make sure you have both tools installed. Although you
don't have to use Docker, I highly recommend it.

Build the images by running:

`docker-compose build`

This process can take a while, but you only need to run it once.

Here's the list of services docker-compose will build for you:

- app: Rails 5.2 web application;
- db: Postgres 9.6 database;
- sidekiq: for background processing (used to fetch the user's releases);
- redis: key/value database required by Sidekiq;

### Database

First, let's generate the configuration file from the template. The example file assumes you're
going to use Docker.

```
cp config/database.yml.example config/database.yml
```

Create and migrate the database by running:

```
docker-compose run --rm app bin/rails db:create db:migrate db:test:prepare
```

### Sidekiq

Docker will setup Sidekiq for you, so you don't have to worry about it.

You can access Sidekiq's dashboard at `/sidekiq`. Remember, however, your user needs to be logged in
and also be an administrator (`User#admin? == true`).

### Starting the server

With everything in place, you just have to start all services by running:

```
docker-compose up
```

The app should be running at `http://localhost:3000`.

## Tests

ReleasedToday uses RSpec and Rubocop for tests. You can run the full test suite with the default rake task:

```
docker-compose run --rm app ./bin/rake
```
