require 'test_helper'

class FormatterTest < Minitest::Test
  def setup
    @under_test = BeerBot::Formatter
    @request_params = { 'user_name' => 'User', 'text' => 'search text' }
  end

  def test_when_no_bars_or_beers
    with_stubbed_beer_formatter do
      with_stubbed_bar_formatter do
        search_result = { bars: [], beers: [] }
        formatted_result = @under_test.format(search_result, @request_params)
        assert_equal formatted_result, ["@User: PhillyTapFinder returned 0 bars and 0 beers for 'search text'.",
          "Bar formatter output", "Beer formatter output"].join("\n")
      end
    end
  end

  def test_when_one_bar_and_no_beers
    with_stubbed_beer_formatter do
      with_stubbed_bar_formatter do
        search_result = { bars: [ 'The only bar' ], beers: [] }
        formatted_result = @under_test.format(search_result, @request_params)
        assert_equal formatted_result, ["@User: PhillyTapFinder returned 1 bar and 0 beers for 'search text'.",
          "Bar formatter output", "Beer formatter output"].join("\n")
      end
    end
  end

  def test_when_no_bars_and_one_beer
    with_stubbed_beer_formatter do
      with_stubbed_bar_formatter do
        search_result = { bars: [], beers: ['one'] }
        formatted_result = @under_test.format(search_result, @request_params)
        assert_equal formatted_result, ["@User: PhillyTapFinder returned 0 bars and 1 beer for 'search text'.",
          "Bar formatter output", "Beer formatter output"].join("\n")
      end
    end
  end

  def test_when_multiple_bars_and_beers
    with_stubbed_beer_formatter do
      with_stubbed_bar_formatter do
        search_result = {
          bars: [ 'The only bar', 'The other bar' ],
          beers: [ 'one', 'two', 'three']
        }
        formatted_result = @under_test.format(search_result, @request_params)
        assert_equal formatted_result, ["@User: PhillyTapFinder returned 2 bars and 3 beers for 'search text'.",
          "Bar formatter output", "Beer formatter output"].join("\n")
      end
    end
  end

private

  def with_stubbed_bar_formatter
    BeerBot::BarFormatter.stub :format, "Bar formatter output" do
      yield
    end
  end

  def with_stubbed_beer_formatter
    BeerBot::BeerFormatter.stub :format, "Beer formatter output" do
      yield
    end
  end
end