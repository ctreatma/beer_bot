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
    @bar.updated_at.must_equal 'Updated: 01/16/2015'
  end

  it 'should have the correct tap list' do
    @bar.beers.must_equal [
      { style: 'Style: Barleywine', origin: 'Origin: Comstock, MI', name: 'Bell\'s Third Coast'},
      { style: 'Style: Saison/Farmhouse Ale', origin: 'Origin: Kansas City, MO', name: 'Boulevard Tank 7' },
      { style: 'Style: IPA', origin: 'Origin: Allentown, PA', name: 'Fegley\'s Brew Works Hop\'Solutely' },
      { style: 'Style: IPA', origin: 'Origin: Boston, MA', name: 'Harpoon IPA' },
      { style: 'Style: Pale Ale', origin: 'Origin: Lyons, CO', name: 'Oskar Blues Dale\'s Pale Ale' }
    ]
  end
end