module Tapfinder
  class Bar < Page

    def name
      @doc.css('#bar-detail .tap-list .tap-list-name').text
    end

    def updated_at
      @doc.css('#bar-detail .tap-list .bar-data .red').text.sub(/Updated:\s+/,'')
    end

    def beers
      @doc.css('#bar-detail .tap-list .grid-list .panel').collect do |beer|
        {
          style: beer.css('.beer-meta h5:first-child').text.sub(/Style:\s+/,''),
          origin: beer.css('.beer-meta h5:nth-child(2)').text.sub(/Origin:\s+/,''),
          name: beer.css('h4 a[href^="/beer"]').text
        }
      end
    end

  end
end