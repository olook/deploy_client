require 'sinatra'
require './lib/delivery_passenger'

post '/receptor' do
  DeliveryPassenger::Lunchbox.new.dispatcher(params[:type], params[:date])
end

