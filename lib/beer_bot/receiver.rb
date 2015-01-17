require 'json'

module BeerBot
  class Receiver
    def receive(params)
      search = Tapfinder::Search.new
      search.find(params)
    end
  end
end
