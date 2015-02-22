require 'sinatra'
require 'sinatra/json'
require 'celluloid/autostart'
require 'beer_bot/slacker'
require 'tapfinder'

module BeerBot
  class App < Sinatra::Base
    include Celluloid

    post '/' do
      self.async.handle_slack_request(params)
    end

    get '/beers' do
      search(params) do |result|
        json result[:beers]
      end
    end

    get '/bars' do
      search(params) do |result|
        json result[:bars]
      end
    end

    private

    def slacker
      @slacker ||= Slacker.new
    end

    def search(params, &block)
      search = Tapfinder::Search.new
      result = search.find(params)
      yield result
    end

    def handle_slack_request(params)
      if slacker.valid?(params)
        search(params) do |result|
          slacker.respond_with(result)
        end
      end
    end
  end
end
