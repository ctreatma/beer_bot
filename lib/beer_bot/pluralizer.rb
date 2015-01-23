module BeerBot
  module Pluralizer
    def string_with_count(string, number)
      "#{number} #{number == 1 ? string : pluralize(string)}"
    end

    def pluralize(string)
      "#{string}s"
    end
  end
end