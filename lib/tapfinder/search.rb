require 'restclient'

module Tapfinder
  class Search
    def find(params)
      puts "Time to search #{client} for #{search_terms_for(params)}"
    end

    def client
      @client ||= RestClient::Resource.new("#{Tapfinder.host}#{Tapfinder.search_path}")
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
