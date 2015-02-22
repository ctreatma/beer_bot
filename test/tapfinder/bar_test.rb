require 'test_helper'

describe Tapfinder::Bar do
  before do
    VCR.use_cassette('wrap_shack') do
      @bar = Tapfinder::Bar.load( [ { 'link' => '/?p=36809' } ] ).first
    end
  end

  it 'should have the correct name' do
    @bar.name.must_equal 'Wrap Shack'
  end

  it 'should have the correct updated date' do
    @bar.updated_at.must_equal '01/16/2015'
  end

  it 'should have the correct tap list' do
    @bar.beers.must_equal [
      { style: 'Barleywine', origin: 'Comstock, MI', name: 'Bell\'s Third Coast'},
      { style: 'Saison/Farmhouse Ale', origin: 'Kansas City, MO', name: 'Boulevard Tank 7' },
      { style: 'IPA', origin: 'Allentown, PA', name: 'Fegley\'s Brew Works Hop\'Solutely' },
      { style: 'IPA', origin: 'Boston, MA', name: 'Harpoon IPA' },
      { style: 'Pale Ale', origin: 'Lyons, CO', name: 'Oskar Blues Dale\'s Pale Ale' }
    ]
  end

  describe '#to_json' do
    it 'should return the expect JSON' do
      expected_json = {
        name: 'Wrap Shack',
        updated_at: '01/16/2015',
        beers: [
          { style: 'Barleywine', origin: 'Comstock, MI', name: 'Bell\'s Third Coast' },
          { style: 'Saison/Farmhouse Ale', origin: 'Kansas City, MO', name: 'Boulevard Tank 7' },
          { style: 'IPA', origin: 'Allentown, PA', name: 'Fegley\'s Brew Works Hop\'Solutely' },
          { style: 'IPA', origin: 'Boston, MA', name: 'Harpoon IPA' },
          { style: 'Pale Ale', origin: 'Lyons, CO', name: 'Oskar Blues Dale\'s Pale Ale' }
        ]
      }.to_json
      @bar.to_json.must_equal expected_json
    end
  end
end