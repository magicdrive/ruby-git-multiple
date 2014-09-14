# conding: utf-8

require 'thor'
require 'git/parallel/process'

module Git
  module Parallel
    class CLI < Thor

      public

      desc "manupulate [OPTIONS]", "parallel manupulation for multiple repositories"
      option :color, alias: "-c", type: :boolean, default: false
      option :job, alias: "-j", type: :numeric, default: 1
      option :dirname, alias: ["-d", "dir"], type: :numeric, default: Dir::pwd
      option maxdepth: :required
      option exec: :required, alias: "-e"
      def manupulate
        base_dir = options[:dirname]
        git_command = options[:exec]

        Dir.chdir(File.expand_path(base_dir)) do
          directories = find_dir(Dir::pwd)
        end
      end

      default_task :manupulate

      private

      def find_dir(base_dir)
        Dir.glob("**/.git").to_a.map { |v| File.dirname(v) }
      end

      def validation()

      end

      def exec_cmd(command)
        puts command

      end
    end
  end
end
