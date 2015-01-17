$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "lib")))
require 'beer_bot'

run BeerBot::App
