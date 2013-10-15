class Search
  class Request
    include API

    def initialize(postcode)
      @postcode = postcode
    end

    def results
      response["feed"]["entry"].map do |s|
        Provider::Request.new(id(s), distance(s)).result
      end
    end

    private

    def id(result)
      result['id'].split('/').last
    end

    def distance(result)
      result['content']['servicesummary']['distance']
    end

    def url
      "#{domain}#{action}#{params}"
    end

    def domain
      "http://v1.syndication.s.integration.choices.nhs.uk"
    end

    def action
      "/services/types/srv0317/postcode/#{postcode}.xml"
    end

    def params
      "?apikey=#{api_key}&range=50"
    end

    def api_key
      ENV["API_KEY"]
    end

    attr_reader :postcode
  end
end
