require 'json'
require 'restclient'
require 'beer_bot/response'

module BeerBot
  class Slacker

    def respond_with(result, params)
      response = BeerBot::Response.new(result, params)
      RestClient.post params['response_url'], response.to_json
    end

    def valid?(params)
      params['token'] == ENV['SLACK_TOKEN']
    end
  end
end
