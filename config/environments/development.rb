CareHomeSearch::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log


  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
end

if ENV['MOCK']
  require 'webmock'
  include WebMock::API
  WebMock.disable_net_connect!(allow_localhost: true)
  stub_request(:get, %r{http://v1\.syndication\.s\.integration\.choices\.nhs\.uk/services/types/srv0317/postcode/ERROR\.xml\?apikey=\w+&range=50}).to_return(File.read('fixtures/services.xml'))
  stub_request(:get, %r{http://v1\.syndication\.s\.integration\.choices\.nhs\.uk/services/types/srv0317/postcode/\w+\.xml\?apikey=\w+&range=50}).to_return(File.read('fixtures/services.xml'))
  stub_request(:get, %r{http://v1\.syndication\.s\.integration\.choices\.nhs\.uk/services/types/srv0317/\d+\.xml\?apikey=}).to_return(File.read('fixtures/service.xml'))
end
