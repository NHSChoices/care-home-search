require 'webmock/cucumber'
WebMock.disable_net_connect!(allow_localhost: true)

Before do
  stub_request(:get, "http://v1.syndication.nhschoices.nhs.uk/services/types/srv0317/postcode/LS1.xml?apikey=&range=50").to_return(File.read('fixtures/services.xml'))
  stub_request(:get, "http://v1.syndication.nhschoices.nhs.uk/services/types/srv0317/postcode/ERROR.xml?apikey=&range=50").to_return(File.read('fixtures/error.xml'))
  stub_request(:get, %r{http://v1\.syndication\.nhschoices\.nhs\.uk/services/types/srv0317/\w+\.xml\?apikey=}).to_return(File.read('fixtures/service.xml'))
end
