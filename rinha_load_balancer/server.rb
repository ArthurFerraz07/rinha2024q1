# frozen_string_literal: true

Bundler.require(:default)

require './load_balancer'

get '*' do
  load_balancer_response = LoadBalancer.instance.get(request.path)

  load_balancer_response.body
rescue StandardError => e
  status 500
  { error: e.message }.to_json
end

post '*' do
  load_balancer_response = LoadBalancer.instance.post(request.path, request.body.read)

  load_balancer_response.body
rescue StandardError => e
  status 500
  { error: e.message }.to_json
end
