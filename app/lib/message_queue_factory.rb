class MessageQueueFactory

  @@default_connection = Bunny.new(automatically_recover: false)

  # @param [String] name
  # @param [Bunny] connection
  # @return [Bunny::queue]
  def self.create(name, connection = nil)
    raise('Invalid queue name') if name.empty?

    connection ||= @@default_connection
    connection.start.channel.queue(name)
  end

  def self.default_connection=(conn)
    @@default_connection = conn
  end

  def self.default_connection
    @@default_connection
  end
end