module MongoTank 

  def self.included(base)
    base.extend ::MongoTank::ClassMethods
    base.field "submitted_to_index_tank?", :type => Boolean, :default => false
    base.class_inheritable_accessor :search_fields, :realtime
    base.after_save :submit_to_index_tank
  end
  
  module ClassMethods
    def search_in(*opts)        
      options = opts.extract_options!.symbolize_keys
      attrs = opts.flatten
      self.search_fields = attrs
      self.realtime = options[:realtime] || false
    end
  end
  
  def prepare_document
    doc = {:_doc_id => "#{self.class}_#{self._id}"}
    
    search_fields.each do |f|
      doc[f] = self[f].to_s
    end
    
    if self.embedded?
      id_hash = {:_retrieving_id => self._parent.id.to_s, :_retrieving_class => self._parent.class.to_s, :_self_id => self.id.to_s, :_self_class => self.class.to_s}
      else
      id_hash = {:_retrieving_id => self.id.to_s, :_retrieving_class => self.class.to_s}
    end
    
    doc.merge!(id_hash)
    doc
  end

  def submit_to_index_tank(opts = {:force => false})
    if self.realtime == true || opts[:force] == true
        client = ::MongoTank::Connection.instance.client
        doc = self.prepare_document
        doc_id = doc.delete(:_doc_id)
        resp = client.document(doc_id).add(doc)
        self.update_attribute("submitted_to_index_tank?", true) if resp == 200
        if self.embedded?
          self.change_parents_state_after_submit
        end
    end
  end
  
  def change_parents_state_after_submit
  
  end
  
end
