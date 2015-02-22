require 'test_helper'

class SearchTest < Minitest::Unit::TestCase
  def setup
    @under_test = Tapfinder::Search.new
  end

  def test_when_search_succeeds_for_all
    VCR.use_cassette('monks') do
      result = @under_test.find({ text: %q[monk's] }, type: :all)
      assert_equal result[:beers].size, 5
      assert_equal result[:bars].size, 1
    end
  end

  def test_when_search_succeeds_for_bars
    VCR.use_cassette('monks') do
      result = @under_test.find({ text: %q[monk's] }, type: :bar)
      assert_nil result[:beers]
      assert_equal result[:bars].size, 1
    end
  end

  def test_when_search_succeeds_for_beers
    VCR.use_cassette('monks') do
      result = @under_test.find({ text: %q[monk's] }, type: :beer)
      assert_equal result[:beers].size, 5
      assert_nil result[:bars]
    end
  end
end