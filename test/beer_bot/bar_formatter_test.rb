require 'test_helper'

class BarFormatterTest < Minitest::Unit::TestCase
  def setup
    @under_test = BeerBot::BarFormatter
  end

  def test_when_one_bar_with_multiple_beers
    @result = [{
      name: 'The Bar',
      beers: [
        { name: 'The Beer', style: 'Swill', origin: 'Colorado' },
        { name: 'The Lite Beer', style: 'Dreck', origin: 'Missouri' }
      ],
      updated_at: '1/27/2015'
    }]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Bars`",
      "1. *The Bar* has 2 beers on tap as of 1/27/2015",
      "    * *The Beer* _(Swill; Colorado)_",
      "    * *The Lite Beer* _(Dreck; Missouri)_"].join("\n")
  end

  def test_when_one_bar_with_one_beer
    @result = [{
      name: 'The Bar',
      beers: [
        { name: 'The Beer', style: 'Swill', origin: 'Colorado' }
      ],
      updated_at: '1/27/2015'
    }]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Bars`",
      "1. *The Bar* has 1 beer on tap as of 1/27/2015",
      "    * *The Beer* _(Swill; Colorado)_"].join("\n")
  end

  def test_when_one_bar_with_no_beers
    @result = [{
      name: 'The Bar',
      beers: [],
      updated_at: '1/27/2015'
    }]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Bars`",
      "1. *The Bar* has 0 beers on tap as of 1/27/2015"].join("\n")
  end

  def test_when_multiple_bars_with_one_beer
    @result = [
      {
        name: 'The First Bar',
        beers: [
          { name: 'The Lite Beer', style: 'Dreck', origin: 'Missouri' }
        ],
        updated_at: '1/27/2015'
      },
      {
        name: 'The Second Bar',
        beers: [
          { name: 'The Beer', style: 'Swill', origin: 'Colorado' }
        ],
        updated_at: '1/26/2015'
      }
    ]

    formatted_result = @under_test.format(@result)
    assert_equal formatted_result, ["`Bars`",
      "1. *The First Bar* has 1 beer on tap as of 1/27/2015",
      "    * *The Lite Beer* _(Dreck; Missouri)_",
      "2. *The Second Bar* has 1 beer on tap as of 1/26/2015",
      "    * *The Beer* _(Swill; Colorado)_"].join("\n")
  end
end