module MongoTank
  class ResultSet
    attr_accessor :time, :matches, :results
    def initialize(response)
      @time = response["search_time"]
      @matches = response["matches"]
      @results = response["results"]
    end
  end
end
