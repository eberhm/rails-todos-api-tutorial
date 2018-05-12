class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_create do |entity|
    MessageQueueFactory.create('domain_events')
                       .publish(DomainEvents::EntityCreated.create(entity).to_json)
  end

  def to_hash
    hash = {}
    attributes.each { |k, v| hash[k] = v }
    hash
  end
end
