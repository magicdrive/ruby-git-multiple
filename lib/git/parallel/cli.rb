# conding: utf-8

require 'thor'
require 'find'
require 'git/parallel/process'

module Git
  module Parallel
    class CLI < Thor

      public
      desc "manupulate [OPTIONS]", "parallel manupulation for multiple repositories"
      option :color, alias: "-c", type: :boolean, default: false
      option :job, alias: "-j", type: :numeric, default: 1
      option :dirname, alias: ["-d", "--dir"], type: :numeric, default: Dir::pwd
      option :maxdepth, default: 1
      option exec: :required, alias: ["-e","-exec"]
      def manupulate
        base_dir = options[:dirname]
        git_command = options[:exec]
      end

      default_task :manupulate

      private
      def find_dir(base_dir, maxdepth)
        result = []
        Find.find(base_dir) do |f|
          fname = File.expand_path(f)
          Find.prune if fname.match %r<^#{base_dir}(?:/.*){#{maxdepth+2}}>
          result.push(File.dirname(fname)) if File.base_name(fname) == ".git"
        end
        return result
      end

      def validation()

      end

      def exec_cmd(command)
        puts command
      end
    end
  end
end
