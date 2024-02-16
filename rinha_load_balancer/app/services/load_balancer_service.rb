# frozen_string_literal: true

Bundler.require(:default)
require 'json'

class LoadBalancerService
  private_class_method :new

  CONTENT_TYPE = { 'Content-Type' => 'application/json' }.freeze
  SERVERS = [
    ENV.fetch('API_INSTANCE_01_URL', 'http://localhost:3001'),
    ENV.fetch('API_INSTANCE_02_URL', 'http://localhost:3002')
  ].compact

  class << self
    def instance
      @instance ||= new
      @instance
    end
  end

  attr_reader :current_server, :servers

  def initialize
    puts '⚡⚡ LoadBalancer instance initialized ⚡⚡'
    puts "\n\n"
    puts "Servers: #{SERVERS}"
    puts "\n\n"

    @servers = SERVERS.map do |server|
      Faraday.new(
        url: server,
        headers: CONTENT_TYPE
      )
    end
    @current_server = 0
  end

  def get(endpoint)
    puts "GET #{endpoint} to server #{current_server_url}"
    servers[current_server].get(endpoint)
  rescue StandardError => e
    puts "Error: #{e.message}"
    raise e
  ensure
    next!
  end

  def post(endpoint, body)
    body = body.to_s
    puts "GET #{endpoint} to server #{current_server_url} with body: #{body}"
    servers[current_server].post(endpoint, JSON.parse(body).to_json, CONTENT_TYPE)
  rescue StandardError => e
    puts "Error: #{e.message}"
    raise e
  ensure
    next!
  end

  private

  def next!
    @current_server = (current_server + 1) % servers_count
  end

  def servers_count
    SERVERS.count
  end

  def current_server_url
    SERVERS[current_server]
  end
end
