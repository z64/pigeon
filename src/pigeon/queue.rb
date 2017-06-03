module Pigeon
  # A cache of Discordrb::Message
  class Queue
    # @return [Array<Discordrb::Message] collection of messages to be dispatched
    attr_reader :queue

    def initialize
      @queue = []
    end

    # @param message [Discordrb::Message] message to enqueue
    def <<(message)
      queue << message
    end

    # Empties the queue and returns a formatted string of the queue's contents
    # @return [String]
    def drain!
      return unless @queue.any?

      str = []

      until queue.empty?
        str << format(@queue.shift)
      end

      str.join("\n")
    end

    private

    # Formats a message for draining
    # TODO: Make this a little configurable
    # @param message [Discordrb::Message]
    # @return [String] the formatted message
    def format(message)
      channel = message.channel.name
      server = message.channel.server.nil?  ? 'PM' : message.channel.server.name
      author = message.channel.private? ? message.author.name : message.author.display_name
      timestamp = message.timestamp.strftime("%Y-%m-%d %H:%M")
      attachments = " [attachments: #{message.attachments.map(&:url).join(', ')}]" if message.attachments.any?

      "[#{timestamp} | #{server} ##{channel}] <#{author}> #{message.content}#{attachments}"
    end
  end
end
