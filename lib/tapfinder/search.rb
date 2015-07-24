require 'restclient'

module Tapfinder
  class Search
    attr_accessor :host

    def initialize
      @host = 'tapfinder-api.herokuapp.com'
    end

    def find(params, options)
      response = RestClient.get "#{host}#{path_for(params, options)}"
      case response.code
      when 200
        puts response.body
        JSON.parse(response.body, symbolize_names: true)
      else
        puts "Failed to search #{client} for #{search_terms_for(params)}"
      end
    end

  private

    def path_for(params, options)
      path = case options[:type]
      when :bar
        '/search/bars'
      when :beer
        '/search/beers'
      else
        '/search'
      end
      "#{path}?text=#{params[:text]}"
    end
  end
end
