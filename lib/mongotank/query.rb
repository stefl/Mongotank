  class MongoTank::Query < Hashie::Clash

    def all
      build_query
      execute_query
      parse_response
    end


    def build_query
      or_queries, and_queries, get = [], [], []
      
      self[:where].each do |field, value|
        or_queries << query_phrase(field, value)
      end
      self[:with].each { |field, value|
        and_queries << query_phrase(field, value)
      } if self[:with]
      @query = "(" + or_queries.join(" OR ") + ")"
      @query = @query + " AND " + and_queries.join(" AND ") if !and_queries.empty?
      @get = (self[:get] + [:_retrieving_id, :_retrieving_class, :_self_id, :_self_class] ).uniq.join(',') if self[:get]
      @start = (self[:page].to_i * 10) - 10 if self[:page]
      @function = self[:function]
      @snippet = self[:snippet]

    end
    
    def execute_query
      client = ::MongoTank::Connection.new.client
      options = {}
      options[:function] = @function if @function
      options[:fetch] = @get if @get
      options[:start] = @start if @start
      options[:snippet] = @snippet if @snippet
      puts @query
      @response = client.search @query , options
    end
    
    def parse_response
      MongoTank::ResultSet.new(@response)
    end
    
    def query_phrase(field, value)
      %Q{#{field}:"#{value}"}
    end  
  end
