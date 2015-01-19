module BeerBot
  class Response
    def initialize(bars, request_params)
      @bars = bars
      @request_params = request_params
    end

    def to_json
      {
        link_names: 1,
        username: 'BeerBot',
        icon_emoji: ':beers:',
        channel: @request_params['channel_id'],
        text: build_response_text
      }.to_json
    end

  private

    def build_response_text
      lines = []
      lines << "@#{@request_params['user_name']}: I #{found} #{bar_or_bars} for '#{@request_params['text']}'."
      lines += build_tap_lists
      lines.join("\n")
    end

    def found
      case @bars.size
      when 0
        found = 'didn\'t find any'
      else
        found = "found #{@bars.size}"
      end
    end

    def bar_or_bars
      @bars.size == 1 ? 'bar' : 'bars'
    end

    def build_tap_lists
      @bars.inject([]) do |lines, bar|
        lines << "1. *#{bar.name}* has #{bar.beers.size} beers on tap"
        bar.beers.each do |beer|
          lines << "    * *#{beer[:name]}* _(#{beer[:style]}, #{beer[:origin]})_"
        end
        lines
      end
    end
  end
end
