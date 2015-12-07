require 'rack/test'
require 'rspec'
require 'simplecov'
SimpleCov.start

ENV['RACK_ENV'] = 'test'
 
require_relative File.join('..', 'bowling')
 
RSpec.configure do |config|
  include Rack::Test::Methods
 
  def app
    Bowling
  end
end

def roll_list(game, rolls)
  rolls.each {|r| game.roll! r}
end
