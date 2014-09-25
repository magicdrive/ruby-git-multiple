# conding: utf-8

require 'stringio'
require 'parallel'
require 'highline'

module Git
  module Multiple
    module PrallelTask

      class << self
        public
        def start(directories, command, options)
          git_command = build_git_cmd(command, options)

          func = block_given? ? Proc.new(&block) : proc {true}

          h = HighLine.new
          Parallel.each(directories, in_threads: options[:jobs]) do |dirname|

            Dir::chdir(dirname)
            disp_dirname = dirname[%r{^#{options[:dirname]}/(.*)$}xo, 1]
            disp_dirname = options[:dirname] if dirname == options[:dirname]
            result = ""

            if options[:"no-color"]
              result << "result git #{command} ::: #{disp_dirname}" << "\n"
            else
              result << "#{h.color("result", :black,:on_green)} " <<
                        "#{h.color("git #{command}", :magenta)} " <<
                        "::: " <<
                        "#{h.color(disp_dirname, :yellow)}" <<
                        "\n"
            end

            result << %x{#{git_command} 2>&1}
            result << "\n"
            next unless func.call(dirname, result)

            puts result
          end
        end

        private
        def build_git_cmd(sub_command, options)
          color_opt = case options[:"no-color"]
                      when true then 'false'
                      else 'always'
                      end

          return "git -c color.ui=#{color_opt} #{sub_command}"
        end

      end

    end
  end
end
