module Dockaswappa
  module DockerCommand
    def docker(command)
      `#{docker_absolute_command_path} #{command}`
    end

    private
      def docker_absolute_command_path
        `which docker`.strip
      end
  end
end
