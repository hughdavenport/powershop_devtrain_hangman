require_relative 'console_io'
require_relative 'language_loader'
require_relative 'graphical_console_gamestate'

class ConsolePresenter
  def initialize(debug: nil,
                 io: ConsoleIO.new,
                 language: LanguageLoader.load("en"),
                 gamestate: GraphicalConsoleGamestate.new)
    @io = io
    @language = language
    @gamestate = gamestate
    @debug = debug
  end

  def display_game(hangman, error=nil)
    @io.clear_screen
    display_error(error) if error
    @io.puts(@gamestate.state(hangman, @language))
  end

  def display_error(error=nil)
    @io.puts(translate(error)) if error
  end

  def ask_for_letter
    message = translate(:please_enter_a_letter)
    @io.print(message)
  end

  def getch
    @io.getch
  end

  def translate(string, args={})
    @language.translate(string, args)
  end
end
