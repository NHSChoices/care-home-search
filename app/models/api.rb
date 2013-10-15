module API

  def request
    @request ||= Faraday.get(url)
  end

  def response
    fail Search::APIError.new(request.env[:body]) unless request.env[:status] == 200
    Hash.from_xml(request.env[:body])
  end

end
