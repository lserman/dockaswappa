module Dockaswappa
  module Error
    class StopFailed < ::StandardError
      def initialize(container)
        super "Docker could not stop container #{container.id}"
      end
    end
  end
end
