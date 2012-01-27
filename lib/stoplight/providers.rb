module Stoplight
  module Providers; end
end

require 'stoplight/providers/provider'
require 'stoplight/providers/multi_project_standard'

# require each drop-in provider
Dir[File.dirname(__FILE__) + '/providers/*.rb'].each { |f| require f }
