class Service
  class Request

    def initialize(url, distance)
      @url = url
      @distance = distance
    end

    def result
      Service.new(data.merge(id: url, distance: distance))
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

    attr_reader :url, :distance
  end
end
