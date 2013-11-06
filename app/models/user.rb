require 'securerandom'

class User < AbstractModel
  UPDATE_ATTRIBUTES = [ :nickname ]
  CREATE_ATTRIBUTES = [ :encrypted_tor_id ]

  before_insert do
    attributes[:api_key] = new_api_key      
  end

  class << self

    def create(attributes)
      raise InvalidAttribute, "Unexpected format" unless attributes.is_a?(Hash)
      attributes.symbolize_keys!

      if attributes.keys.sort != CREATE_ATTRIBUTES.sort
        raise InvalidAttribute, "Attributes list does not match pattern (#{create_attributes.sort.join(', ')})"
      end

      if attributes.values.any?(&:empty?)
        raise InvalidAttribute, "All attributes should be present"
      end

      attributes[:api_key] = new_api_key

      Sequel::Model.db[self.name.tableize.to_sym].insert(attributes)

      return attributes[:api_key]
    end

    def new_api_key
      SecureRandom.hex(36)
      # rand(36**255).to_s(36)
    end
  end
end