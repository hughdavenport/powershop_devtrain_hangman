require 'io/console'
class IO

    attr_reader :input
    attr_reader :output

    def initialize(params = {})
        @input = params.fetch(:input, STDIN)
        @output = params.fetch(:output, STDOUT)
    end

    def get_input
        @input.getch
    end

    def write_output(text)
        @output.print text
        @output.flush
    end

end
