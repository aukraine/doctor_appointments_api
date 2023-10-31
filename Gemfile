source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 7.0.8'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'bootsnap', require: false
gem 'bcrypt'
gem 'jwt'
gem 'pundit'
gem 'dry-validation'
gem 'alba'
gem 'oj'

group :development do
  gem 'annotate'
end

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 5.0'
  gem 'faker'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
end

group :test do
  gem 'database_cleaner'
end
