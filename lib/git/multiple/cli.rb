# conding: utf-8

require 'thor'
require 'find'
require 'git/multiple/parallel_task'
require 'pry'

module Git
  module Multiple
    class CLI < Thor

      public
      desc "manupulate [OPTIONS]", "parallel manupulation for multiple repositories"
      option :color, alias: "-c", type: :boolean
      option :job, alias: "-j", type: :numeric, default: 1
      option :dirname, alias: ["-d", "--dir"], type: :numeric, default: Dir::pwd
      option :maxdepth, default: 1
      option :exec , required: true, alias: ["-e","-exec"]
      def manupulate
        base_dir = options[:dirname]
        git_command = options[:exec]
        directories = find_dir(base_dir, options[:maxdepth])
        Git::Multiple::PrallelTask.start(directories, git_command, options)
      end

      default_task :manupulate

      private
      def find_dir(base_dir, maxdepth)
        result = []
        Find.find(base_dir) do |f|
          fname = File.expand_path(f)
          Find.prune if fname.match %r<^#{base_dir}(?:/.*){#{maxdepth.to_i + 2}}>
          Find.prune if File.exists?("#{File.dirname(fname)}/.git-parallel-skip")
          result.push(File.dirname(fname)) if File.basename(fname) == ".git"
        end
        return result
      end

    end
  end
end
