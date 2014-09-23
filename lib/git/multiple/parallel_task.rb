# conding: utf-8

require 'systemu'
require 'stringio'
require 'parallel'


module Git
  module Multiple
    module PrallelTask

      class << self
        public
        def start(directories, command, options)
          git_command = build_git_cmd(command, options)

          func = block_given? ? Proc.new(&block) : proc {true}

          Parallel.each(directories, in_threads: options[:job]) do |dirname|

            disp_dirname = dirname[%r{^#{options[:dirname]}/(.*)$}xo, 1]
            disp_dirname = options[:dirname] if dirname == options[:dirname]

            result = "#{disp_dirname} ::: git #{command}\n"
            result << %x{#{git_command}}
            result << "\n"
            next unless func.call(dirname, result)

            puts result
          end
        end

        private
        def build_git_cmd(sub_command, options)
          color_opt = case %x{git config color.ui}
                      when /(?:^(?:always|true))/xo then 'always'
                      when /(?:^false$)/xo then 'false'
                      end
          color_opt = ->() {
            case options[:color]
            when true  then 'always'
            when false then 'false'
            end
          }.call() unless options[:color].nil?

          return "git -c color.ui=#{color_opt} #{sub_command}"
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
