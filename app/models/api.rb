module API

  def request
    @request ||= Faraday.get(url)
  end

  def response
    unless request.env[:status] == 200
      fail Search::APIError, request.env[:body].inspect
    end
    Hash.from_xml(request.env[:body])
  end

end
