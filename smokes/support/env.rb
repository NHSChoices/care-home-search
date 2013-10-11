require 'cucumber'
require 'capybara'
require 'capybara-webkit'
require 'mocha/api'

Capybara.default_selector = :css
Capybara.current_driver = :webkit
Capybara.app_host = ENV['APP_URL'] || 'http://localhost:8080'

World(Capybara::DSL)
