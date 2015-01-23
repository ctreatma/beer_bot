require 'test_helper'

class FormatterTest < Minitest::Unit::TestCase
  def setup
    @under_test = BeerBot::Formatter
    @request_params = { 'user_name' => 'User', 'text' => 'search text' }
  end

  def test_when_no_bars
    with_stubbed_bar_formatter do
      search_result = { bars: [] }
      formatted_result = @under_test.format(search_result, @request_params)
      assert_equal formatted_result, ["@User: PhillyTapFinder returned 0 bars for 'search text'.",
        "Bar formatter output"].join("\n")
    end
  end

  def test_when_one_bar
    with_stubbed_bar_formatter do
      search_result = { bars: [ 'The only bar' ] }
      formatted_result = @under_test.format(search_result, @request_params)
      assert_equal formatted_result, ["@User: PhillyTapFinder returned 1 bar for 'search text'.",
        "Bar formatter output"].join("\n")
    end
  end

  def test_when_multiple_bars
    with_stubbed_bar_formatter do
      search_result = { bars: [ 'The only bar', 'The other bar' ] }
      formatted_result = @under_test.format(search_result, @request_params)
      assert_equal formatted_result, ["@User: PhillyTapFinder returned 2 bars for 'search text'.",
        "Bar formatter output"].join("\n")
    end
  end

private

  def with_stubbed_bar_formatter
    BeerBot::BarFormatter.stub :format, "Bar formatter output" do
      yield
    end
  end
end