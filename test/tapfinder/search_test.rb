require 'test_helper'

class SearchTest < Minitest::Unit::TestCase
  def setup

    @under_test = Tapfinder::Search.new
  end

  def test_when_search_succeeds
    VCR.use_cassette('monks') do
      result = @under_test.find({ text: %q[monk's] })
      assert_equal result[:beers].size, 5
      assert_equal result[:bars].size, 1
    end
  end
end