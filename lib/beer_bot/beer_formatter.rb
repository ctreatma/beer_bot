module BeerBot
  class BeerFormatter
    def self.format(beers)
      if beers.size > 0
        "`Beers`\n#{self.build_bars_and_events(beers)}"
      end
    end

  private
    extend Pluralizer

    def self.build_bars_and_events(beers)
      beers.each_with_index.inject([]) do |lines, (beer, index)|
        bars = beer[:bars]
        events = beer[:events]
        lines << "#{index + 1}. *#{beer[:name]}* _(#{beer[:style]}; " +
                 "#{beer[:origin]})_ is on tap at " +
                 "#{string_with_count('bar', bars.size)} and " +
                 "#{string_with_count('event', events.size)}"
        bars.each do |bar|
          lines << "    * *#{bar[:name]}* (#{bar[:address]}) as of #{bar[:updated_at]}"
        end
        events.each do |event|
          lines << "    * *#{event[:name]}* on #{event[:date]} " +
                   "at #{event[:bar]} (#{event[:address]})"
        end
        lines
      end.join("\n")
    end
  end
end