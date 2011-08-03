module MongoTank
  class Hit
  
    def initialize
    end
    
    def get_instances
      @instances = {}
      model_ids = {}
      @entries = []
      results.group_by{|x| x["_retrieving_class"]}.each do |grp, values|
        ids = values.collect{|x| x["_retrieving_id"]}
        model_ids[grp] = ids
      end

      model_ids.each do |klass, klass_ids|
        @entries = klass.constantize.where(:_id.in => klass_ids).all
        @entries.each do |entry|
          @instances["#{entry.class}_#{entry.id}"] = entry
        end
      end
    end
  end
end
