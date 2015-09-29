module Dockaswappa
  class Container
    include Dockaswappa::Logger

    attr_reader :id

    def initialize(id)
      @id = id
    end

    def port_mapping_to(port)
      `docker inspect --format='{{(index (index .NetworkSettings.Ports "#{port}/tcp") 0).HostPort}}' #{id}`
    end

    def stop
      logger.info "Stopping container #{id}"
      `docker stop #{id}`
      if $?.success?
        logger.info "Stopped container #{id}"
        id
      else
        raise Dockaswappa::Error::StopFailed.new(self)
      end
    end

    def up_on_port?(port)
      response = `curl -m 5 -i 0.0.0.0:#{port_mapping_to(port)}/healthcheck`
      !!(response =~ /200 OK/)
    end
  end
end
