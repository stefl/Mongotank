module MongoTank
  class Connection
    #include Singleton
    attr_accessor :client, :fields, :session
    def initialize
      api = IndexTank::Client.new ENV['INDEXTANK_API_URL'] 
      self.client = api.indexes(ENV['INDEXTANK_INDEX'])
      self.fields = []
    end
  end
end
