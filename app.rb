require 'sinatra'
require './lib/delivery_passenger'

configure do
  set :port, 3334
end

post '/receptor' do
  DeliveryPassenger::Lunchbox.new.dispatcher(params[:type], params[:date])
end

