module BeerBot
  class Response
    def initialize(bars, request_params)
      @response_fields = {
        username: 'BeerBot',
        icon_emoji: ':beers:',
        channel: request_params['channel_id'],
        text: build_response_text(bars, request_params)
      }
    end

    def to_json
      @response_fields.to_json
    end

  private

    def build_response_text(bars, request_params)
      lines = []
      lines << "@#{request_params['user_name']}: I found #{bars.size} bars for '#{request_params['text']}':"
      bars.each do |bar|
        lines << "1. #{bar.name} has #{bar.beers.size} beers on tap"
        bar.beers.each do |beer|
          lines << "    * #{beer[:name]} (#{beer[:style]}, #{beer[:origin]})"
        end
      end
      lines.join("\n")
    end
  end
end