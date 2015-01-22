module BeerBot
  class Formatter

    def format(result, request_params)
      lines = []
      lines << "@#{request_params['user_name']}: PhillyTapFinder returned #{string_with_count('bar', result.size)} for '#{request_params['text']}'."
      lines += build_tap_lists(result)
      lines.join("\n")
    end

    def build_tap_lists(result)
      result.each_with_index.inject([]) do |lines, (bar, index)|
        beers = bar.beers
        lines << "#{index + 1}. *#{bar.name}* has #{string_with_count('beer', beers.size)} on tap"
        beers.each do |beer|
          lines << "    * *#{beer[:name]}* _(#{beer[:style]}, #{beer[:origin]})_"
        end
        lines
      end
    end

  private

    def string_with_count(string, number)
      "#{number} #{number == 1 ? string : pluralize(string)}"
    end

    def pluralize(string)
      "#{string}s"
    end
  end
end