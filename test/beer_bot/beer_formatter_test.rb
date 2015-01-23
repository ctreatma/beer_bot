require 'test_helper'

class BeerFormatterTest < Minitest::Unit::TestCase
  def setup
    @under_test = BeerBot::BeerFormatter
    @result = []
  end

  def test_when_one_beer_at_multiple_bars_and_no_events
    mock_beer 'The Beer', 'Style', 'Origin', [
      { name: 'Good Bar', address: 'Awesometown', updated_at: '1/27/2015' },
      { name: 'Shitty Bar', address: 'Wherever', updated_at: '1/26/2015' }
    ], []

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style, Origin)_ is on tap at 2 bars and 0 events",
      "    * *Good Bar* (Awesometown) as of 1/27/2015",
      "    * *Shitty Bar* (Wherever) as of 1/26/2015"].join("\n")
  end

  def test_when_one_beer_at_one_bar_and_no_events
    mock_beer 'The Beer', 'Style', 'Origin', [
      { name: 'Shitty Bar', address: 'Wherever', updated_at: '1/26/2015' }
    ], []

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style, Origin)_ is on tap at 1 bar and 0 events",
      "    * *Shitty Bar* (Wherever) as of 1/26/2015"].join("\n")
  end

  def test_when_one_beer_at_one_bar_and_one_event
    mock_beer 'The Beer', 'Style', 'Origin', [
      { name: 'Good Bar', address: 'Awesometown', updated_at: '1/27/2015' }
    ], [
      { name: 'Shitty Event', bar: 'Shitty Bar', address: 'Wherever', date: '1/31/2015' }
    ]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style, Origin)_ is on tap at 1 bar and 1 event",
      "    * *Good Bar* (Awesometown) as of 1/27/2015",
      "    * *Shitty Event* on 1/31/2015 at Shitty Bar (Wherever)"].join("\n")
  end

  def test_when_one_beer_at_no_bars_and_multiple_events
    mock_beer 'The Beer', 'Style', 'Origin', [], [
      { name: 'Good Event', bar: 'Good Bar', address: 'Awesometown', date: '2/1/2015' },
      { name: 'Shitty Event', bar: 'Shitty Bar', address: 'Wherever', date: '2/12/2015' }
    ]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style, Origin)_ is on tap at 0 bars and 2 events",
      "    * *Good Event* on 2/1/2015 at Good Bar (Awesometown)",
      "    * *Shitty Event* on 2/12/2015 at Shitty Bar (Wherever)"].join("\n")
  end

  def test_when_one_beer_at_no_bars_or_events
    mock_beer 'The Beer', 'Style', 'Origin', [], []

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style, Origin)_ is on tap at 0 bars and 0 events"].join("\n")
  end

  def test_when_multiple_beers_at_one_bar_and_no_events
    mock_beer 'The Beer', 'Style', 'Origin', [
      { name: 'Shitty Bar', address: 'Wherever', updated_at: '1/26/2015' }
    ], []

    mock_beer 'The Lite Beer', 'Style 2', 'Origin 2', [
      { name: 'Good Bar', address: 'Awesometown', updated_at: '1/27/2015' }
    ], []

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style, Origin)_ is on tap at 1 bar and 0 events",
      "    * *Shitty Bar* (Wherever) as of 1/26/2015",
      "2. *The Lite Beer* _(Style 2, Origin 2)_ is on tap at 1 bar and 0 events",
      "    * *Good Bar* (Awesometown) as of 1/27/2015"].join("\n")
  end


private

  # TODO: Refactor the bar
  # class so that it can
  # be stubbed here instead
  def mock_beer(name, style, origin, bars, events)
    beer = Minitest::Mock.new
    beer.expect :name, name
    beer.expect :style, style
    beer.expect :origin, origin
    beer.expect :bars, bars
    beer.expect :events, events
    @result << beer
  end
end