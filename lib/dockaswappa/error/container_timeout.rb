module Dockaswappa
  module Error
    class ContainerTimeout < ::StandardError
      def initialize(timeout)
        super "Waited for container to come up for #{timeout}, but it didn't"
      end
    end
  end
end
