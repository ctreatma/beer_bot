require 'test_helper'

class BarFormatterTest < Minitest::Unit::TestCase
  def setup
    @under_test = BeerBot::BarFormatter
    @result = []
  end

  def test_when_one_bar_with_multiple_beers
    mock_bar 'The Bar', [
      { name: 'The Beer', style: 'Swill', origin: 'Colorado' },
      { name: 'The Lite Beer', style: 'Dreck', origin: 'Missouri' }
    ], '1/27/2015'

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Bars`",
      "1. *The Bar* has 2 beers on tap as of 1/27/2015",
      "    * *The Beer* _(Swill; Colorado)_",
      "    * *The Lite Beer* _(Dreck; Missouri)_"].join("\n")
  end

  def test_when_one_bar_with_one_beer
    mock_bar 'The Bar', [
      { name: 'The Beer', style: 'Swill', origin: 'Colorado' }
    ], '1/27/2015'

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Bars`",
      "1. *The Bar* has 1 beer on tap as of 1/27/2015",
      "    * *The Beer* _(Swill; Colorado)_"].join("\n")
  end

  def test_when_one_bar_with_no_beers
    mock_bar 'The Bar', [], '1/27/2015'

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Bars`",
      "1. *The Bar* has 0 beers on tap as of 1/27/2015"].join("\n")
  end

  def test_when_multiple_bars_with_one_beer
    mock_bar 'The First Bar', [
      { name: 'The Lite Beer', style: 'Dreck', origin: 'Missouri' }
    ], '1/27/2015'
    mock_bar 'The Second Bar', [
      { name: 'The Beer', style: 'Swill', origin: 'Colorado' }
    ], '1/26/2015'

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Bars`",
      "1. *The First Bar* has 1 beer on tap as of 1/27/2015",
      "    * *The Lite Beer* _(Dreck; Missouri)_",
      "2. *The Second Bar* has 1 beer on tap as of 1/26/2015",
      "    * *The Beer* _(Swill; Colorado)_"].join("\n")
  end

private

  # TODO: Refactor the bar
  # class so that it can
  # be stubbed here instead
  def mock_bar(name, beers, updated_at)
    bar = Minitest::Mock.new
    bar.expect :name, name
    bar.expect :beers, beers
    bar.expect :updated_at, updated_at
    @result << bar
  end
end