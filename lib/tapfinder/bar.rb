require 'nokogiri'

module Tapfinder
  class Bar
    def initialize(link)
      response = RestClient.get url_for(link)
      @doc = Nokogiri::HTML(response.body)
    end

    def name
      @doc.css('#bar-detail .tap-list .tap-list-name').text
    end

    def updated_at
      @doc.css('#bar-detail .tap-list .bar-data .red').text
    end

    def beers
      @doc.css('#bar-detail .tap-list .grid-list .panel').collect do |beer|
        {
          style: beer.css('.beer-meta h5:first-child').text,
          origin: beer.css('.beer-meta h5:nth-child(2)').text,
          name: beer.css('a[href^=/beer]').text
        }
      end
    end

    def self.load(bars_as_json)
      bars_as_json.collect do |bar|
        Bar.new(bar['link'])
      end
    end

  private

    def url_for(link)
      "#{Tapfinder.host}#{link}"
    end

  end
end