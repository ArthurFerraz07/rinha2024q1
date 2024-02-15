# frozen_string_literal: true

Bundler.require(:default)
require 'json'

class LoadBalancer
  private_class_method :new

  SERVERS = [
    'http://localhost:3001',
    'http://localhost:3002'
  ]

  class << self
    def instance
      @instance ||= new
      @instance
    end
  end

  attr_reader :current_server, :servers

  def request!(method, endpoint, body = {})
    response = case method
               when :get
                 servers[current_server].get(endpoint)
               when :post
                 servers[current_server].post(endpoint, body.to_json)
               end

    next!

    response
  end

  private

  def initialize
    @servers = SERVERS.map do |server|
      Faraday.new(
        url: server,
        headers: { 'Content-Type' => 'application/json' }
      )
    end
    @current_server = 0
  end

  def next!
    @current_server = (current_server + 1) % servers_count
  end

  def servers_count
    @servers.count
  end
end
