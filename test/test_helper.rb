require 'minitest/autorun'
require 'vcr'
require 'beer_bot'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end
