require 'json'
require 'celluloid/autostart'
require 'restclient'
require 'beer_bot/response'

module BeerBot
  class Slacker
    include Celluloid

    def handle(params)
      if valid?(params)
        search = Tapfinder::Search.new
        result = search.find(params)
        response = BeerBot::Response.new(result, params)
        respond_with(response)
      end
    end

    def respond_with(response)
      RestClient.post web_hook_url, response.to_json
    end

  private

    def valid?(params)
      params['token'] == ENV['SLACK_TOKEN']
    end

    def web_hook_url
      "https://hooks.slack.com/services#{ENV['INCOMING_WEBHOOK_PATH']}"
    end
  end
end
