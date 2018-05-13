ruby '2.4.3'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'
gem 'active_model_serializers', '~> 0.10.0'
gem 'administrate', github: 'thoughtbot/administrate'
gem 'bourbon'
gem 'bugsnag'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'encrypted_strings', require: false
gem 'factory_girl_rails', '~> 4.0'
gem 'foreman'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jwt'
gem 'kaminari'
gem 'omniauth-spotify'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rspotify'
gem 'sass-rails', '~> 5.0'
gem 'sendgrid-ruby'
gem 'sidekiq'
gem 'uglifier', '>= 1.3.0'
gem 'octicons_helper'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
end

group :test do
  gem 'database_cleaner'
  gem 'vcr'
  gem 'webmock'
  gem 'timecop'
end
