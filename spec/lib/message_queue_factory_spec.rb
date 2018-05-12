

describe MessageQueueFactory do
  queue_name = 'my-queue'

  # @return [MessageQueueFactory]
  def create_queue(name)
    MessageQueueFactory.create(name, BunnyMock.new)
  end

  it 'should raise error when no name is given' do
    expect { create_queue('') }.to raise_error('Invalid queue name')
  end

  it 'should create a queue and a channel with the name passed in the constructor' do
    expect(create_queue(queue_name).name).to eq(queue_name)
  end

  it 'should post a message into the queue' do
    queue = create_queue(queue_name)
    queue.publish('yesss!', priority: 5)

    expect(queue.message_count).to eq(1)

    payload = queue.pop
    expect(queue.message_count).to eq(0)

    expect(payload[:message]).to eq('yesss!')
    expect(payload[:options][:priority]).to eq(5)
  end
end