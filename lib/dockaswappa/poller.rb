require 'timeout'

module Dockaswappa
  class Poller
    attr_reader :timeout

    def initialize(timeout)
      @timeout = timeout
    end

    def poll_until(&block)
      Timeout::timeout(timeout) do
        loop do
          yield ? break : sleep(1)
        end
      end
    rescue Timeout::Error
      raise Dockaswappa::Error::ContainerTimeout.new timeout
    end
  end
end
