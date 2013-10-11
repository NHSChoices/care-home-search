require 'simplecov'
require 'coveralls'

SimpleCov.start do
  add_filter '/vendor'
  add_filter '/spec'
  add_filter '/features'
  coverage_dir 'reports/coverage'
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
  config.order = "random"
end
