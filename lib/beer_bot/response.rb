require 'beer_bot/formatter'

module BeerBot
  class Response
    def initialize(result, request_params)
      @result = result
      @request_params = request_params
    end

    def to_json
      {
        link_names: 1,
        username: 'BeerBot',
        icon_emoji: ':beers:',
        text: Formatter.format(@result, @request_params),
        response_type: 'ephemeral'
      }.to_json
    end
  end
end
