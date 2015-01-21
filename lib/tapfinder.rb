require 'tapfinder/page'
require 'tapfinder/bar'
require 'tapfinder/beer'
require 'tapfinder/search'

module Tapfinder
  def self.host
    'www.phillytapfinder.com'
  end

  def self.search_path
    '/wp-content/plugins/phillytapfinder/'
  end
end
