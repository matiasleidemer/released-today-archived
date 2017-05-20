ruby '2.3.4'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'rspotify'
gem 'devise'
gem 'omniauth-spotify'
gem 'semantic-ui-sass', git: 'https://github.com/doabit/semantic-ui-sass.git'
gem 'administrate', github: 'thoughtbot/administrate'
gem 'active_model_serializers', '~> 0.10.0'
gem 'factory_girl_rails', '~> 4.0'
gem 'bugsnag'
gem 'kaminari'

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
end

group :test do
  gem 'database_cleaner'
  gem 'vcr'
  gem 'webmock'
end
