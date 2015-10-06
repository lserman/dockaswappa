module Dockaswappa
  module DockerCommand
    def docker(command)
      command = "#{docker_absolute_command_path} #{command}"
      logger.info "Running command: #{command}"
      `#{command}`
    end

    private
      def docker_absolute_command_path
        `which docker`.strip
      end
  end
end
