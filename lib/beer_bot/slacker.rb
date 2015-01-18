require 'json'
require 'celluloid/autostart'
require 'restclient'
require 'beer_bot/response'

module BeerBot
  class Slacker
    include Celluloid

    def handle(params)
      search = Tapfinder::Search.new
      result = search.find(params)
      response = BeerBot::Response.new(result, params)
      respond_with(response)
    end

    def respond_with(response)
      RestClient.post web_hook_url, response.to_json
    end

  private

    def web_hook_url
      "https://hooks.slack.com/services#{ENV['INCOMING_WEBHOOK_PATH']}"
    end
  end
end
