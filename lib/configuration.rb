# frozen_string_literal: true

module RubyOuath
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :callback_url
    attr_accessor :cookie_name
    attr_accessor :provider
    attr_accessor :webserver_port

    def cookie_name
      @authorize_address || 'ruby_oauth_state'
    end

    def webserver_port
      @webserver_port || '8000'
    end

    def callback_url
      @callback_url || "http://localhost:#{webserver_port}/callback"
    end
  end
end
