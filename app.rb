require 'sinatra'
require './lib/delivery_passenger'

configure do
  set :port, 3334
end

post '/receptor' do
  parsed_params = JSON.parse(params.first[0])
  DeliveryPassenger::Lunchbox.new.dispatcher(parsed_params['type'], parsed_params['date'])
  "The package was recepted!"
end

