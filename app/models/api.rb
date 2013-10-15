module API

  def request
    @request ||= Faraday.get(url)
  end

  def response
    fail Search::APIError unless request.env[:status] == 200
    Hash.from_xml(request.env[:body])
  end

end
