class Search
  class APIError < StandardError
    def initialize(message)
      super(message)
    end
  end
end
