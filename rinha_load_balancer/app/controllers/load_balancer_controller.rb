# frozen_string_literal: true

Bundler.require(:default)

require './app/services/load_balancer_service'

get '*' do
  load_balancer_response = LoadBalancerService.instance.get(request.path)

  load_balancer_response.body
rescue StandardError => e
  status 500
  { error: e.message }.to_json
end

post '*' do
  load_balancer_response = LoadBalancerService.instance.post(request.path, request.body.read)

  load_balancer_response.body
rescue StandardError => e
  status 500
  { error: e.message }.to_json
end
