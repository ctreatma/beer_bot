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
        text: format_result
      }.to_json
    end

  private

    def format_result
      formatter = Formatter.new
      formatter.format(@result, @request_params)
    end
  end
end
