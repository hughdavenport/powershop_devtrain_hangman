require_relative 'consoleIO'
require_relative 'languageLoader'
class ConsolePresenter

  def initialize(io: ConsoleIO.new, language: LanguageLoader.load("en"))
    @io = io
    @language = language
  end

  def display_game(hangman)
    @io.clear_screen
    display_error if @error
    @io.print_text_with_newline get_gamestate(hangman)
  end

  def add_error(error)
    @error = error
  end

  def display_error()
    @io.print_text_with_newline get_string(@error)
    @error = nil
  end

  def ask_for_letter
    message = get_string :pleaseenteraletter
    @io.print_text message
    @io.get_char
  end

  def get_gamestate(hangman)
    text = ""
    if hangman.finished?
      text += get_string :gameover
      text += "\n"
      text += get_string(hangman.won? ? :youwon : :youlost)
      text += "\n"
      text += get_string(:youhadlivesremaining, {:lives => hangman.score})
      text += "\n"
      text += get_string(:finalguesswas, {:guess => get_guess_word(hangman)})
      text += "\n"
      text += get_string(:youhadguessed, {:guesses => hangman.guesses.join(" ")})
      text += "\n"
      text += get_string(:thewordwas, {:word => hangman.word})
      text += "\n"
    else
      text += get_string(:youhavelivesremaining, {:lives => hangman.score})
      text += "\n"
      text += get_string(:currentguessis, {:guess => get_guess_word(hangman)})
      text += "\n"
      text += get_string(:youhaveguessed, {:guesses => hangman.guesses.join(" ")})
      text += "\n"
    end
    text += hangman.inspect + "\n"
    text
  end

  def get_guess_word(hangman)
    hangman.guessed_word.map{|letter| letter.nil? ? "_" : letter}.join()
  end

  def get_string(string, args={})
    @language.get_string(string, args)
  end

end
