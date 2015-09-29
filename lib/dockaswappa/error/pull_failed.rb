module Dockaswappa
  module Error
    class PullFailed < ::StandardError
      def initialize(output)
        super "Docker pull failed: #{output}"
      end
    end
  end
end
