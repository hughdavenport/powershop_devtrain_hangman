require 'io/console'
class IO

    attr_reader :input
    attr_reader :output

    def initialize(params = {})
        @input = params.fetch(:input, STDIN)
        @output = params.fetch(:output, STDOUT)
    end

    def clear_screen
        # ANSI control sequences, see http://www.termsys.demon.co.uk/vtansi.htm
        beginning_of_line = "\e[H"
        erase_screen      = "\e[2J"
        print_text beginning_of_line + erase_screen
    end

    def get_char
        @input.getch
    end

    def print_text(text)
        @output.print text
        @output.flush
    end

    def print_newline
        print_text "\n"
    end

    def print_text_with_newline(text)
        print_text text + "\n"
    end

end
