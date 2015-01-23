require 'test_helper'

describe 'A beer that is available at bars and events' do
  before do
    VCR.use_cassette('supplication') do
      @beer = Tapfinder::Beer.load( [ { 'link' => '/beer/russian-river-supplication/' } ] ).first
    end
  end

  it 'should have the correct name' do
    @beer.name.must_equal 'Russian River Supplication'
  end

  it 'should have the correct style' do
    @beer.style.must_equal 'Sour/Wild-Fermented Ale'
  end

  it 'should have the correct origin' do
    @beer.origin.must_equal 'Santa Rosa, CA'
  end

  it 'should have the correct bar list' do
    @beer.bars.must_equal [
      { name: 'Good Dog', address: '224 South 15th St. (between Walnut &...', updated_at: '01/22/15' },
      { name: 'Barcade', address: '1114 Frankford Ave.', updated_at: '01/22/15' }
    ]
  end

  it 'should have the correct event list' do
    @beer.events.must_equal [
      { name: 'Russian River', bar: 'Isaac Newton\'s', address: '18 South State St., ...', date: '01/31/2015' }
    ]
  end
end

describe 'A beer that is available only at events' do
  before do
    VCR.use_cassette('consecration') do
      @beer = Tapfinder::Beer.load( [ { 'link' => '/?p=35601' } ] ).first
    end
  end

  it 'should have the correct name' do
    @beer.name.must_equal 'Russian River Consecration'
  end

  it 'should have the correct style' do
    @beer.style.must_equal 'Sour/Wild-Fermented Ale'
  end

  it 'should have the correct origin' do
    @beer.origin.must_equal 'Santa Rosa, CA'
  end

  it 'should have the correct bar list' do
    @beer.bars.must_equal []
  end

  it 'should have the correct event list' do
    @beer.events.must_equal [
      { name: 'Russian River', bar: 'Isaac Newton\'s', address: '18 South State St., ...', date: '01/31/2015' },
      { name: 'Sour Bowl', bar: 'Brü Craft & Wurst', address: '1316 Chestnut St.', date: '01/25/2015' }
    ]
  end
end