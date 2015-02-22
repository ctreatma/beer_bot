require 'nokogiri'
require 'json'

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

    def to_json(*args)
      hash_for_conversion = self.class.json_fields.inject({}) do |hash, field|
        hash[field] = self.send(field)
        hash
      end
      hash_for_conversion.to_json
    end

    class << self
      attr_accessor :json_fields
    end


  private

    def url_for(link)
      "#{Tapfinder.host}#{link}"
    end
  end
end