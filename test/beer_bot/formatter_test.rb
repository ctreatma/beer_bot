require 'test_helper'

class FormatterTest < Minitest::Unit::TestCase
  def setup
    @under_test = BeerBot::Formatter.new
    @request_params = { 'user_name' => 'User', 'text' => 'search text' }
    @result = []
  end

  def test_when_one_bar_with_multiple_beers
    mock_bar 'The Bar', [
      { name: 'The Beer', style: 'Swill', origin: 'Colorado' },
      { name: 'The Lite Beer', style: 'Dreck', origin: 'Missouri' }
    ]

    formatted_result = @under_test.format(@result, @request_params)
    assert_equal formatted_result, ["@User: I found 1 bar for 'search text'.",
      "1. *The Bar* has 2 beers on tap",
      "    * *The Beer* _(Swill, Colorado)_",
      "    * *The Lite Beer* _(Dreck, Missouri)_"].join("\n")
  end

  def test_when_one_bar_with_one_beer
    mock_bar 'The Bar', [
      { name: 'The Beer', style: 'Swill', origin: 'Colorado' }
    ]

    formatted_result = @under_test.format(@result, @request_params)
    assert_equal formatted_result, ["@User: I found 1 bar for 'search text'.",
      "1. *The Bar* has 1 beer on tap",
      "    * *The Beer* _(Swill, Colorado)_"].join("\n")
  end

  def test_when_one_bar_with_no_beers
    mock_bar 'The Bar', []

    formatted_result = @under_test.format(@result, @request_params)
    assert_equal formatted_result, ["@User: I found 1 bar for 'search text'.",
      "1. *The Bar* has 0 beers on tap"].join("\n")
  end

  def test_when_multiple_bars
    mock_bar 'The First Bar', []
    mock_bar 'The Second Bar', []

    formatted_result = @under_test.format(@result, @request_params)
    assert_equal formatted_result, ["@User: I found 2 bars for 'search text'.",
      "1. *The First Bar* has 0 beers on tap",
      "2. *The Second Bar* has 0 beers on tap"].join("\n")
  end

private

  # TODO: Refactor the bar
  # class so that it can
  # be stubbed here instead
  def mock_bar(name, beers)
    bar = Minitest::Mock.new
    bar.expect :name, name
    bar.expect :beers, beers
    @result << bar
  end
end