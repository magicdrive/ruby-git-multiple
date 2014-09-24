# spec_helper file.
require File.expand_path('../lib/git/multiple', File.dirname(__FILE__))
require 'stringio'
require 'pry'

def capture(stream)
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

PROJECT_ROOT = "#{File.expand_path("../", File.dirname(__FILE__))}"

__END__
