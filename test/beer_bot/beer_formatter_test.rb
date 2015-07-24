require 'test_helper'

class BeerFormatterTest < Minitest::Unit::TestCase
  def setup
    @under_test = BeerBot::BeerFormatter
  end

  def test_when_one_beer_at_multiple_bars_and_no_events
    @result = [{
      name: 'The Beer',
      style: 'Style',
      origin: 'Origin',
      bars: [
        { name: 'Good Bar', address: 'Awesometown', updated_at: '1/27/2015' },
        { name: 'Shitty Bar', address: 'Wherever', updated_at: '1/26/2015' }
      ],
      events: []
    }]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style; Origin)_ is on tap at 2 bars and 0 events",
      "    * *Good Bar* (Awesometown) as of 1/27/2015",
      "    * *Shitty Bar* (Wherever) as of 1/26/2015"].join("\n")
  end

  def test_when_one_beer_at_one_bar_and_no_events
    @result = [{
      name: 'The Beer',
      style: 'Style',
      origin: 'Origin',
      bars: [
        { name: 'Shitty Bar', address: 'Wherever', updated_at: '1/26/2015' }
      ],
      events: []
    }]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style; Origin)_ is on tap at 1 bar and 0 events",
      "    * *Shitty Bar* (Wherever) as of 1/26/2015"].join("\n")
  end

  def test_when_one_beer_at_one_bar_and_one_event
    @result = [{
      name: 'The Beer',
      style:  'Style',
      origin: 'Origin',
      bars: [
        { name: 'Good Bar', address: 'Awesometown', updated_at: '1/27/2015' }
      ],
      events: [
        { name: 'Shitty Event', bar: 'Shitty Bar', address: 'Wherever', date: '1/31/2015' }
      ]
    }]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style; Origin)_ is on tap at 1 bar and 1 event",
      "    * *Good Bar* (Awesometown) as of 1/27/2015",
      "    * *Shitty Event* on 1/31/2015 at Shitty Bar (Wherever)"].join("\n")
  end

  def test_when_one_beer_at_no_bars_and_multiple_events
    @result = [{
      name: 'The Beer',
      style: 'Style',
      origin: 'Origin',
      bars: [],
      events: [
        { name: 'Good Event', bar: 'Good Bar', address: 'Awesometown', date: '2/1/2015' },
        { name: 'Shitty Event', bar: 'Shitty Bar', address: 'Wherever', date: '2/12/2015' }
      ]
    }]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style; Origin)_ is on tap at 0 bars and 2 events",
      "    * *Good Event* on 2/1/2015 at Good Bar (Awesometown)",
      "    * *Shitty Event* on 2/12/2015 at Shitty Bar (Wherever)"].join("\n")
  end

  def test_when_one_beer_at_no_bars_or_events
    @result = [{
      name: 'The Beer',
      style: 'Style',
      origin: 'Origin',
      bars: [],
      events: []
    }]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style; Origin)_ is on tap at 0 bars and 0 events"].join("\n")
  end

  def test_when_multiple_beers_at_one_bar_and_no_events
    @result = [
      {
        name: 'The Beer',
        style: 'Style',
        origin: 'Origin',
        bars: [
          { name: 'Shitty Bar', address: 'Wherever', updated_at: '1/26/2015' }
        ],
        events: []
      },
      {
        name: 'The Lite Beer',
        style: 'Style 2',
        origin: 'Origin 2',
        bars: [
          { name: 'Good Bar', address: 'Awesometown', updated_at: '1/27/2015' }
        ],
        events: []
      }
    ]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Beers`",
      "1. *The Beer* _(Style; Origin)_ is on tap at 1 bar and 0 events",
      "    * *Shitty Bar* (Wherever) as of 1/26/2015",
      "2. *The Lite Beer* _(Style 2; Origin 2)_ is on tap at 1 bar and 0 events",
      "    * *Good Bar* (Awesometown) as of 1/27/2015"].join("\n")
  end
end