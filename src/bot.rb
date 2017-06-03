require 'discordrb'
require 'rufus-scheduler'

require_relative 'pigeon/config'
require_relative 'pigeon/gmail'
require_relative 'pigeon/queue'

module Pigeon
  module_function

  # @param file [String] YAML file to load
  # @return [Config] configuration instance
  def config(file = 'config.yml')
    @config ||= Config.from_yaml(file)
  end

  # @return [GMailAccount] email account to send emails to
  def gmail
    @gmail ||= GMailAccount.new(
      config.gmail_username,
      config.gmail_password
    )
  end

  # TODO: Change type to :user
  # @return [Discordrb::Bot]
  def bot
    @bot ||= Discordrb::Bot.new(
      token: config.token,
      type: :bot
    )
  end

  # Instance of a Rufus::Scheduler
  # @return [Rufus::Scheduler]
  def scheduler
    @scheduler ||= Rufus::Scheduler.new
  end

  # Queues a message to be sent eventually
  def queue(message = nil)
    @queue ||= Queue.new
    return @queue unless message

    @queue << message
  end

  # Mails the queue and empties it
  def dispatch_queue!
    puts queue.drain!
  end

  # Registers event handlers on our bot
  def register_handlers
    # Queue every message we receive, if it is in our configured servers list.
    bot.message do |event|
      next unless config.servers.include?(event.server.id)
      queue(event.message)
    end

    # Once we're ready, start dispatching the queue every `config.interval`
    bot.ready do
      scheduler.every(config.interval) { dispatch_queue! }
    end
  end

  # Registers handlers on the bot and connects to Discord to start
  # processing events.
  def run!
    register_handlers
    bot.run
  end
end
