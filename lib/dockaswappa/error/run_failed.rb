module Dockaswappa
  module Error
    class RunFailed < ::StandardError
      def initialize(output)
        super "Docker run failed: #{output}"
      end
    end
  end
end
