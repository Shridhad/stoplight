$:.unshift File.dirname(__FILE__)
require 'config/boot'

run Sinatra::Application
