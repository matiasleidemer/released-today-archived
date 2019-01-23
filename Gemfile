ruby '2.5.3'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers', '~> 0.10.0'
gem 'administrate', '~> 0.11.0'
gem 'bootsnap'
gem 'bourbon'
gem 'bugsnag'
gem 'devise', '~> 4.5.0'
gem 'encrypted_strings', require: false
gem 'factory_girl_rails', '~> 4.0'
gem 'foreman'
gem 'jwt'
gem 'kaminari'
gem 'octicons_helper'
gem 'omniauth-spotify'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.2.2'
gem 'rspotify'
gem 'sass-rails', '~> 5.0'
gem 'sendgrid-ruby'
gem 'sidekiq'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'dotenv-rails', '~> 2.6.0'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'bullet', '~> 5.9.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'vcr'
  gem 'webmock'
  gem 'timecop'
end
