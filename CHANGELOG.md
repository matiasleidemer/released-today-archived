# CHANGELOG

## [unreleased]

### Updated

- Rails to version 5.2.5

## [2.0.1]

### Updated

- Rails to version 5.2.4.5

## [2.0.0]

### Added

- Docker setup

### Fixed

- Refresh spotify token before fetching new user's releases

### Updated

- Simplecov gem to version 0.21.2

## [1.1.8]

### Fixed

- Sidekiq as ActiveJob's default adapter

### Updated

- pg gem to version 1.2.3

## [1.1.7]

### Updated

- puma to version 4.3.5

## [1.1.6]

### Updated

- webmock gem to version 3.8.3
- rails to version 5.2.4.3
- kaminari to version 1.2.1

## [1.1.5]

### Added

- Code climate integration
- TravisCI integration

## [1.1.4]

### Added

- Simplecov configuration

### Updated

- Administrate gem to 0.13
- Rails gem to 5.2.4.2
- Puma gem to version 3.12.4

## [1.1.3]

### Updated

- rack gem to version 2.0.8
- puma gem to version 3.12.2
- nokogiri gem to version 1.10.7
- loofah gem to version 2.4.0

## [1.1.2]

### Fixed

- Authenticate spotify before starting FetchAndSendNewReleasesJob

### Added

- factory_bot_rails gem to replace factory_girl_rails (which is deprecated)

### Updated

- bootsnap gem to version 1.4.4
- bourbon gem to version 4.3.4
- Bugsnag configuration to use rails secrets
- bugsnag gem to version 6.11.1
- rspec-rails gem to version 3.8.2
- byebug gem to version 11.0.1
- set database_cleaner gem version to 1.7.0
- timecop gem to version 0.9.1
- vcr gem to version 5.0.0
- webmock gem to version 3.6.0
- sidekiq gem to version 5.2.7
- octicons_helper gem to version 9.1.1
- foreman gem to version 0.85.0
- kaminari gem to version 1.1.1
- devise gem to version 4.7.1

### Removed

- JWT gem

## [1.1.1]

### Fixed

- Spotify env variable names

## [1.1.0]

### Updated

- rails to 5.2.3
- ruby to 2.6.3
- client_id and client_secret variables renamed to include spotify in their names
- Readme with new Ruby/Rails versions and Spotify instructions

### Removed

- client_callback_url env variable
- spotify_token_swap_encryption_secret env variable
- spring gem

## [1.0.4]

### Added

- .ruby-version file

### Updated

- Rspotify version to 1.27.0
- Database cleaner version to 1.7.0

## [1.0.3]

### Removed

- Released::Jwt class
- SpotifyTokensController

## [1.0.2]

### Updated

- Sinatra version to 2.0.5
- Ffi version to 1.10.0

## [1.0.1]

### Added

- Changelog

### Updated

- Ruby version to 2.5.3
- Rails version to 5.2.2

### Removed

- API routes
