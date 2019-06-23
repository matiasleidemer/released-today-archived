# CHANGELOG

## [unreleased]

### Fixed

- Authenticate spotify before starting FetchAndSendNewReleasesJob

### Updated

- bootsnap gem to version 1.4.4
- bourbon gem to version 4.3.4

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
