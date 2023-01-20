# frozen_string_literal: true

require 'webrick'
require 'securerandom'
require 'rest-client'
require 'json'
require 'base64'

require_relative 'request_handler'
require_relative 'request_handlers/index'
require_relative 'helpers/response'
require_relative 'helpers/request'
require_relative 'request_handlers/login'
require_relative 'request_handlers/callback'
require_relative 'request_handlers/me'
require_relative 'request_handlers/refresh_token'
require_relative 'lib/configuration'
require_relative 'initializers/ruby_oauth'
require_relative 'lib/provider_client'

server = WEBrick::HTTPServer.new Port: RubyOuath.configuration.webserver_port
server.mount '/', RequestHandler
server.mount '/assets', WEBrick::HTTPServlet::FileHandler, './assets'
trap('INT') { server.shutdown }

server.start
