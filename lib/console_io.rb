require 'io/console'

class ConsoleIO
  attr_reader :input
  attr_reader :output

  # ANSI control sequences, see http://www.termsys.demon.co.uk/vtansi.htm
  ANSI_BEGINNING_OF_LINE = "\e[H"
  ANSI_ERASE_SCREEN      = "\e[2J"

  # Unicode control characters (ISO 6429), see https://en.wikipedia.org/wiki/C0_and_C1_control_codes
  END_OF_TEXT         = "\u0003" # CTRL-c
  END_OF_TRANSMISSION = "\u0004" # CTRL-d

  def initialize(input: STDIN, output: STDOUT)
    @input = input
    @output = output
  end

  def clear_screen
    print("#{ANSI_BEGINNING_OF_LINE}#{ANSI_ERASE_SCREEN}")
  end

  def getch
    @input.getch.tap do |character|
      raise Interrupt if character == END_OF_TEXT
      raise EOFError if character == END_OF_TRANSMISSION
    end
  end

  def print(text)
    @output.print(text)
    @output.flush
  end

  def puts(text="")
    print("#{text}\n")
  end
end
