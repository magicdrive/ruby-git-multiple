require 'thor'

module Git
  module Parallel
    class CLI < Thor

      class << self

      end

      desc "manupulate [OPTIONS]", "parallel manupulation for multiple repositories"
      def manupulate

      end

      default_task :manupulate
    end
  end
end
