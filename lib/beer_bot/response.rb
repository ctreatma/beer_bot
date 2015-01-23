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
        channel: @request_params['channel_id'],
        text: Formatter.format(@result, @request_params)
      }.to_json
    end
  end
end
