require 'rubygems'
require 'bundler'

Bundler.require
require 'active_support/inflector'

require 'lib/stoplight'
require 'application'

require 'logger'
$logger = Logger.new('log/application.log')
use Rack::CommonLogger, $logger
