require 'capistrano/all'
require 'dockaswappa/version'
require 'dockaswappa/logger'
require 'dockaswappa/docker_command'
require 'dockaswappa/docker'
require 'dockaswappa/container'
require 'dockaswappa/poller'

require 'dockaswappa/error/pull_failed'
require 'dockaswappa/error/run_failed'
require 'dockaswappa/error/stop_failed'
require 'dockaswappa/error/container_timeout'

module Dockaswappa
end
