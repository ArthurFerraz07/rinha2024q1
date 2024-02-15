
# frozen_string_literal: true

Bundler.require(:default)

require './server'

set :port, 3000
set :bind, '0.0.0.0'
use Rack::Logger

puts "\n\n"
puts "⚡⚡⚡ Load Balancer Running ⚡⚡⚡\n\n"

Sinatra::Application.run!

exit 0
