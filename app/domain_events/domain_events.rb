module DomainEvents
  class EntityCreated

    # @return [EntityCreated]
    attr_reader :data, :guid, :event_type, :entity_type

    def self.create(entity)
      entity_type = entity.class.name.demodulize

      if entity.instance_of?(User)
        EntityCreated.new(
          entity.as_json(except: [:password_digest]),
          entity_type
        )
      else
        EntityCreated.new(entity.as_json, entity_type)
      end
    end

    def initialize(data, entity_type)
      @guid = SecureRandom.uuid
      @data = data
      @event_type = self.class.name.split('::').last
      @entity_type = entity_type
    end
  end
end