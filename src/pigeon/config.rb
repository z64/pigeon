require 'yaml'

module Pigeon
  # Class representing configuration values for this app.
  class Config
    # @return [String] token to log into Discord with
    attr_reader :token

    # @return [Array<Integer, String] array of server IDs to send logs to
    attr_reader :server_ids

    # @return [String] gmail username
    attr_reader :gmail_username

    # @return [String] gmail password
    attr_reader :gmail_password

    # @return [String] syndication interval. To be passed to `Rufus::Scheduler#every`.
    attr_reader :interval

    def initialize(token: nil, servers: nil, gmail_username: nil, gmail_password: nil, interval: nil)
      @token = token
      @servers = servers
      @gmail_username = gmail_username
      @gmail_password = gmail_password
      @interval = interval
    end

    # Instances a new Config from a YAML file
    # @param filename [String] name of the file to load
    def self.from_yaml(filename)
      new YAML.load_file(filename).inject({}) { |memo, (k,v)| memo[k.to_sym] = v ; memo }
    end
  end
end
