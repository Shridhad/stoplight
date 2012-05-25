require 'rubygems'
require 'spork'

Spork.prefork do
  require 'rack/test'
  require 'bundler'

  Bundler.require(:default, :test)

  require 'webmock/rspec'

  require './lib/stoplight'

  RSpec.configure do |config|
    config.include Rack::Test::Methods
  end
end

Spork.each_run do

end
