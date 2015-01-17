require 'sinatra'
require 'beer_bot/receiver'
require 'tapfinder'

module BeerBot
  class App < Sinatra::Base
    post '/' do
      BeerBot.receiver.receive(params)
    end
  end

  def self.receiver
    @receiver ||= Receiver.new
  end
end
