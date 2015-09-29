require 'logger'

module Dockaswappa
  module Logger
    def logger
      @_logger ||= ::Logger.new(STDOUT)
    end
  end
end
