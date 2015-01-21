module Tapfinder
  class Beer < Page

    def name
      @doc.css('#tap-detail .tap-list .tap-list-name').text
    end

    def origin
      @doc.css('#tap-detail .tap-list .origin > strong').text
    end

    def style
      @doc.css('#tap-detail .tap-list .origin strong:first-child').text
    end

    def bars
      @doc.css('#tap-detail .tap-list .grid-list:nth-of-type(1) .panel').collect do |bar|
        {
          name: bar.css('h4 a[href^="/bar"]').text,
          address: bar.css('li:nth-child(2) p').text,
          updated_at: bar.css('.updated').text
        }
      end
    end

    def events
      @doc.css('#tap-detail .tap-list .grid-list .events-panel').collect do |bar|
        {
          name: bar.css('h4 a[href^="/event"]').text,
          bar: bar.css('h4 a[href^="/bar"]').text,
          date: bar.css('li:nth-child(3) p').text,
          address: bar.css('li:nth-child(4) p').text
        }
      end
    end

  end
end