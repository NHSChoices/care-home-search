class Provider
  class Request

    def initialize(id, distance=nil)
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

    def response
      fail Search::APIError unless request.env[:status] == 200
      Hash.from_xml(request.env[:body])
    end

    def request
      @request ||= Faraday.get("#{url}.xml?apikey=#{api_key}")
    end

    def api_key
      ENV['API_KEY']
    end

    def domain
      'http://v1.syndication.s.integration.choices.nhs.uk'
    end

    def url
      "#{domain}/services/types/srv0317/#{id}"
    end

    attr_reader :id, :distance
  end
end
