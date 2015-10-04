module Dockaswappa
  class Docker
    include Dockaswappa::Logger

    attr_reader :image

    def initialize(image)
      @image = image
    end

    def pull
      logger.info "Pulling image..."
      out = `docker pull #{image}`
      if $?.success?
        logger.info out
        out
      else
        raise Dockaswappa::Error::PullFailed.new(out)
      end
    end

    def ps
      `docker ps --filter name=#{base_name} -q`.split("\n").map do |id|
        Dockaswappa::Container.new id
      end
    end

    def run
      id = `docker run -d -p 80 -e VIRTUAL_HOST=app --name #{timestamped_name} #{image}:latest`
      if $?.success?
        logger.info "Container running: #{id}"
        Dockaswappa::Container.new id
      else
        raise Dockaswappa::Error::RunFailed.new(id)
      end
    end

    private
      def base_name
        'app'
      end

      def timestamped_name
        "#{base_name}_#{Time.now.to_i}"
      end
  end
end
