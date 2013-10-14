source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 2.3.2.0'

gem 'id'
gem 'fendhal'
gem 'faraday'

gem 'unicorn'
gem 'capistrano', group: :development

group :production do
  gem 'rails_12factor'
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end

gem 'jslint_on_rails', require: false
gem 'brakeman', require: false
gem 'cucumber-rails', '~> 1.3.0', require: false
gem 'rubocop'
gem 'rspec-rails'
gem 'simplecov', require: false
gem 'coveralls', require: false

group :development, :test do
  gem 'travis'
  gem 'webmock', require: false
  gem 'mocha', require: false
  gem 'launchy', '~> 2.1.2'
  gem 'capybara-webkit'
end
