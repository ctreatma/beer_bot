require 'simplecov'

SimpleCov.start do
  add_filter 'test'
  add_filter 'vendor'
end
SimpleCov.minimum_coverage 84.35

require 'minitest/autorun'
require 'vcr'
require 'beer_bot'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end
