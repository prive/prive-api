class AbstractModel
  class << self
    def update(id, attributes)
      raise InvalidAttribute, "Unexpected format" unless attributes.is_a?(Hash)
      raise InvalidAttribute, "ID absent" if id.nil?
      raise InvalidAttribute, "ID=#{id} is not safe" unless id.safe_string?

      attributes.symbolize_keys!

      attributes.each do |k, v|
        unless self::UPDATE_ATTRIBUTES.include?(k)
          raise InvalidAttribute, "#{self.name}##{k} is not public update attribute"
        end
      end

      Sequel::Model.db[self.name.tableize.to_sym].where(:encrypted_tor_id => id).update(attributes)
    end

    def create(attributes)
      raise InvalidAttribute, "Unexpected format" unless attributes.is_a?(Hash)
      attributes.symbolize_keys!    

      if attributes.keys.sort != self::CREATE_ATTRIBUTES.sort
        raise InvalidAttribute, "Attributes list does not match pattern (#{create_attributes.sort.join(', ')})"
      end

      if attributes.values.any?(&:empty?)
        raise InvalidAttribute, "All attributes should be present"
      end

      before_insert_block.call

      Sequel::Model.db[self.name.tableize.to_sym].insert(attributes) 
    end

    protected

    def before_insert_block
      @before_insert || lambda{}
    end

    def before_insert(&block)
      @before_insert_block = block
    end
  end
end