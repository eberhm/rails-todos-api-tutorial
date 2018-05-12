describe DomainEvents::EntityCreated do
  it 'should remove the password information if is a User entity on create' do
    event = DomainEvents::EntityCreated.create(User.new)
    expect(event.entity_type).to eq('User')
    expect(event.data).not_to include(:password_digest)
  end

  it 'should have the proper entity_type on create' do
    { User: User.new, Item: Item.new, Todo: Todo.new }
      .each do |type, entity|
        expect(DomainEvents::EntityCreated.create(entity).entity_type)
          .to eq(type.to_s)
      end
  end

  it 'should have the proper event_type' do
    event = DomainEvents::EntityCreated.create(User.new)
    expect(event.event_type).to eq('EntityCreated')
  end
end