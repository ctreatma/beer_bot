require 'nokogiri'

module Tapfinder
  class Page
    def initialize(link)
      response = RestClient.get url_for(link)
      @doc = Nokogiri::HTML(response.body)
    end

    def self.load(pages_as_json)
      pages_as_json.collect do |page|
        self.new(page['link'])
      end
    end

  private

    def url_for(link)
      "#{Tapfinder.host}#{link}"
    end
  end
end