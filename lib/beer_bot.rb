require 'sinatra'
require 'sinatra/json'
require 'celluloid/autostart'
require 'beer_bot/slacker'
require 'tapfinder/search'

module BeerBot
  class App < Sinatra::Base
    include Celluloid

    post '/' do
      self.async.handle_slack_request(params)
    end

    get '/beers' do
      search(params, type: :beer) do |result|
        BeerFormatter.format result[:beers]
      end
    end

    get '/bars' do
      search(params, type: :bar) do |result|
        BarFormatter.format result[:bars]
      end
    end

    private

    def slacker
      @slacker ||= Slacker.new
    end

    def search(params, options = {}, &block)
      search = Tapfinder::Search.new
      result = search.find(params, options)
      yield result
    end

    def handle_slack_request(params)
      if slacker.valid?(params)
        search(params, type: :all) do |result|
          slacker.respond_with(result, params)
        end
      end
    end
  end
end
