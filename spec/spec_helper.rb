require 'simplecov'
require 'coveralls'

SimpleCov.start do
  add_filter '/vendor'
  add_filter '/spec'
  add_filter '/features'
end

require 'id'
require 'models/address'
require 'models/contact'
require 'models/care_home'
require 'models/search/validations'
require 'models/search'

RSpec.configure do |config|
  config.mock_with :mocha
  config.order = "random"
end
