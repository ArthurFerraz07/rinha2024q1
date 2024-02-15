# frozen_string_literal: true

Bundler.require(:default)

require './load_balancer'

get '/*' do
  load_balancer_response = LoadBalancer.instance.request!(
    request.request_method.downcase.to_sym,
    request.path,
    request.body.read
  )

  {
    method: request.request_method,
    path: request.path_info,
    body: request.body.read,
    response: {
      status: load_balancer_response.status,
      headers: load_balancer_response.headers,
      body: load_balancer_response.body
    }
  }.to_json
# rescue StandardError => e
#   print 'Error occured on request!'
#   print e.inspect

#   {
#     error: e.inspect,
#     backtrace: e.backtrace
#   }.to_json
end
