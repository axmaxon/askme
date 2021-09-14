source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'rails-i18n', '~> 6.0.0'
gem 'recaptcha'

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', '~> 1.19', require: false
  gem 'rubocop-rails', '~> 2.11', require: false
  gem 'spring'
end

group :production do
  gem 'pg'
end
