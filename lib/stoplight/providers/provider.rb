#
# This is a base provider that all providers must inherit from
#
require 'httparty'

# Provider is an abstract class that all providers inherit from. It requires that a specified format be returned. This way, stoplight
# doesn't care who it's talking to, as long as it guarantees certain information.
module Stoplight::Providers
  class Provider
    include HTTParty

    attr_reader :options, :response

    # Initializes a hash `@options` of default options
    def initialize(options = {})
      if options['url'].nil?
        raise ArgumentError, "'url' must be supplied as an option to the Provider. Please add 'url' => '...' to your hash."
      end

      @options = options

      # load the data
      load_server_data
    end

    # `projects` must return an array of Stoplight::Project
    # see Stoplight::Project for more information on the spec
    def projects
      raise Stoplight::Exceptions::NoParserError.new "No projects parser provided. All Stoplight providers must provide a projects method!"
    end

    private
    # Makes a request to the given server `url` and assigns an instance variable
    # `@response` to the result. It only returns a string. The `result` method is
    # responsible for parsing the string into a usable hash.
    def load_server_data
      url = @options['url']

      url_options = {}

      if @options['username'] || @options['password']
        url_options[:basic_auth] = {
          :username => @options['username'],
          :password => @options['password']
        }
      end

      if @options['owner_name']
        url_options[:query] = {
          :owner_name => @options['owner_name']
        }
      end

      url_options.delete_if { |k,v| v.nil? }

      @response = HTTParty.get(url, url_options)
    end
  end
end
