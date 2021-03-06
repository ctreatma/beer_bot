require 'restclient'

module Tapfinder
  class Search
    def find(params)
      response = client.post search_terms_for(params)
      case response.code
      when 200
        json_response = JSON.parse(response.body)
        bars = Tapfinder::Bar.load(json_response['bars'])
        beers = Tapfinder::Beer.load(json_response['beers'])
        { bars: bars, beers: beers }
      else
        puts "Failed to search #{client} for #{search_terms_for(params)}"
      end
    end

    def client
      @client ||= RestClient::Resource.new("https://#{Tapfinder.host}#{Tapfinder.search_path}")
    end

    def search_terms_for(params)
      {
        class: 'Search',
        process: 'searchAll',
        searchTerm: params[:text]
      }
    end
  end
end
