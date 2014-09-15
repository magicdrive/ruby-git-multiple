# conding: utf-8

require 'systemu'
require 'stringio'

module Git
  module Parallel
    module Process
      class<<self
        public
        def start(directories, git_command, options)

          result_array = []

          plist = []
          directories.each_with_index do |dirname, index|
            result = capture(:stdout) do
              Dir.chdir(dirname)
              pid= spawn(<<-SHELL)
                git #{git_command}
              SHELL
              Process::wait(pid)
            end
          end

        end

      end

      private


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
