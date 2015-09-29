require 'dockaswappa'

namespace :docker do
  task :swap do
    image   = fetch(:dockaswappa_image)
    timeout = fetch(:dockaswappa_timeout, 15)
    docker  = Dockaswappa::Docker.new image
    poller  = Dockaswappa::Poller.new(timeout: timeout)
    logger  = Logger.new(STDOUT)

    docker.pull
    old_containers = docker.ps
    new_container  = docker.run

    poller.poll_until do
      logger.info "Polling container..."
      new_container.up_on_port? 80
    end

    old_containers.each &:stop
  end
end
