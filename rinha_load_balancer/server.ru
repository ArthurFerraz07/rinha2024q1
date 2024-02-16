# frozen_string_literal: true

Bundler.require(:default)

require './app/controllers/load_balancer_controller'

set :default_content_type, :json
set :port, 9999
set :bind, '0.0.0.0'
use Rack::Logger

puts "\n\n"
puts '⚡⚡⚡ Load Balancer Server Running ⚡⚡⚡'
puts "\n\n"

LoadBalancerService.instance
Sinatra::Application.run!

exit 0
