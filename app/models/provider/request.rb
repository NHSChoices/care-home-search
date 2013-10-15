class Provider
  class Request
    include API

    def initialize(id, distance = nil)
      @id = id
      @distance = distance
    end

    def result
      Provider.new(data.merge(id: id, distance: distance))
    end

    private

    def data
      response['feed']['entry']['content']['service']
    end

    def api_key
      ENV['API_KEY']
    end

    def domain
      'http://v1.syndication.s.integration.choices.nhs.uk'
    end

    def url
      "#{domain}/services/types/srv0317/#{id}.xml?apikey=#{api_key}"
    end

    attr_reader :id, :distance
  end
end
