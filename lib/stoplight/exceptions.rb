module Stoplight
  module Exceptions
    class NoParserError < Exception; end
    class NoProviderError < Exception; end
    class UnknownProviderError < Exception; end
  end
end
