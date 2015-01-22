module BeerBot
  class Formatter

    def format(result, request_params)
      lines = []
      lines << "@#{request_params['user_name']}: I #{found(result)} #{bar_or_bars(result)} for '#{request_params['text']}'."
      lines += build_tap_lists(result)
      lines.join("\n")
    end

    def found(result)
      case result.size
      when 0
        found = 'didn\'t find any'
      else
        found = "found #{result.size}"
      end
    end

    def bar_or_bars(result)
      result.size == 1 ? 'bar' : 'bars'
    end

    def build_tap_lists(result)
      result.each_with_index.inject([]) do |lines, (bar, index)|
        beers = bar.beers
        lines << "#{index + 1}. *#{bar.name}* has #{beers.size} #{beer_or_beers(beers)} on tap"
        beers.each do |beer|
          lines << "    * *#{beer[:name]}* _(#{beer[:style]}, #{beer[:origin]})_"
        end
        lines
      end
    end

    def beer_or_beers(list)
      list.size == 1 ? 'beer' : 'beers'
    end
  end
end