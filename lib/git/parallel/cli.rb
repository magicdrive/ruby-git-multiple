# conding: utf-8

require 'thor'

module Git
  module Parallel
    class CLI < Thor

      public

      option :color, alias: "-c", type: :boolean, default: false
      option :exec, alias: "-e", require: true
      option :job, alias: "-j", type: :numeric, default: 1
      option :dirname, alias: ["-d", "dir"], type: :numeric, default: Dir::pwd
      option :maxdepth,  require: true
      desc "manupulate [OPTIONS]", "parallel manupulation for multiple repositories"
      def manupulate

      end

      default_task :manupulate

      private

      def exec_cmd(command)

      end
    end
  end
end
