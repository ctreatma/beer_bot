require 'sinatra'
require 'beer_bot/slacker'
require 'tapfinder'

module BeerBot
  class App < Sinatra::Base
    post '/' do
      BeerBot.slacker.async.handle(params)
    end
  end

  def self.slacker
    @slacker ||= Slacker.new
  end
end
