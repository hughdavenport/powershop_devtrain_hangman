require_relative 'console_io'
require_relative 'language_loader'

class ConsolePresenter
  def initialize(debug: nil, io: ConsoleIO.new, language: LanguageLoader.load("en"))
    @io = io
    @language = language
    @debug = debug
  end

  def display_game(hangman, error=nil)
    @io.clear_screen
    display_error(error) if error
    @io.puts(get_gamestate(hangman))
  end

  def display_error(error=nil)
    @io.puts(get_string(error)) if error
  end

  def ask_for_letter
    message = get_string :please_enter_a_letter
    @io.print(message)
    @io.getch
  end

  def get_gamestate(hangman)
    text = ""
    if hangman.finished?
      text += get_string(:game_over)
      text += "\n"
      text += get_string(hangman.won? ? :you_won : :you_lost)
      text += "\n"
      text += get_string(:you_had_lives_remaining, {:lives => hangman.score})
      text += "\n"
      text += get_string(:final_guess_was, {:guess => get_guess_word(hangman)})
      text += "\n"
      text += get_string(:you_had_guessed, {:guesses => hangman.guesses.join(" ")})
      text += "\n"
      text += get_string(:the_word_was, {:word => hangman.word})
      text += "\n"
    else
      text += get_string(:you_have_lives_remaining, {:lives => hangman.score})
      text += "\n"
      text += get_string(:current_guess_is, {:guess => get_guess_word(hangman)})
      text += "\n"
      text += get_string(:you_have_guessed, {:guesses => hangman.guesses.join(" ")})
      text += "\n"
    end
    text += hangman.inspect + "\n" if @debug
    text
  end

  def get_guess_word(hangman)
    hangman.guessed_word.map { |letter| letter.nil? ? "_" : letter }.join
  end

  def get_string(string, args={})
    @language.get_string(string, args)
  end
end
