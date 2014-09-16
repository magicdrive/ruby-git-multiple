# conding: utf-8

require 'systemu'
require 'stringio'
require 'parallel'

module Git
  module Parallel
    module Process

      class << self
        public
        def start(directories, command, options)
          git_command = build_git_cmd(command, options)

          func = block_given? ? Proc.new(&block) : proc {true}

          Parallel.each(directories, in_threads: options[:job]) do |dirname|
            std_result = capture(:stdout) do
              Dir.chdir(dirname)
              Process::wait(spawn(git_command))
            end
            next if func.call(dirname, std_result)
            puts result
          end

        end

        private
        def build_git_cmd(sub_command, options)
          git_option = %{}
          git_option << "-c color.ui awlways" if options[:color]

          return "git #{git_option} #{sub_command}"
        end

        def capture(stream, &block)
          begin
            stream = stream.to_s
            eval "$#{stream} = StringIO.new"
            yield
            result = eval("$#{stream}").string
          ensure
            eval("$#{stream} = #{stream.upcase}")
          end
          return result
        end

      end

    end
  end
end
