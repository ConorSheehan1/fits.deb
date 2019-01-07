module Helpers
  # https://github.com/erikhuda/thor/blob/577fcc457805451eb5e0c15fc382dfb65a8af224/spec/helper.rb#L49
  # https://bokstuff.com/testing-thor-command-lines-with-rspec/
  def capture(stream)
    begin
      stream = stream.to_s
      eval("$#{stream} = StringIO.new")
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end
    result
  end
end
