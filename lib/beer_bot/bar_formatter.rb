module BeerBot
  class BarFormatter
    def self.format(bars)
      if bars.size > 0
        "`Bars`\n#{self.build_tap_lists(bars)}"
      end
    end

  private
    extend Pluralizer

    def self.build_tap_lists(bars)
      bars.each_with_index.inject([]) do |lines, (bar, index)|
        beers = bar.beers
        lines << "#{index + 1}. *#{bar.name}* has " +
                 "#{string_with_count('beer', beers.size)} " +
                 "on tap as of #{bar.updated_at}"
        beers.each do |beer|
          lines << "    * *#{beer[:name]}* _(#{beer[:style]}, #{beer[:origin]})_"
        end
        lines
      end.join("\n")
    end
  end
end