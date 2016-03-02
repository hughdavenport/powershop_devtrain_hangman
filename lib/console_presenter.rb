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
    @io.puts(gamestate(hangman))
  end

  def display_error(error=nil)
    @io.puts(get_string(error)) if error
  end

  def ask_for_letter
    message = get_string(:please_enter_a_letter)
    @io.print(message)
  end

  def getch
    @io.getch
  end

  def gamestate(hangman)
    gamestate = if hangman.finished?
      finished_gamestate(hangman)
    else
      in_progress_gamestate(hangman)
    end
    gamestate += hangman.inspect if @debug
    gamestate
  end

  def finished_gamestate(hangman)
    [
      get_string(:game_over),
      get_string(hangman.won? ? :you_won : :you_lost),
      get_string(:you_had_lives_remaining, {:lives => hangman.score}),
      get_string(:final_guess_was, {:guess => get_guess_word(hangman)}),
      get_string(:you_had_guessed, {:guesses => hangman.guesses.join(" ")}),
      get_string(:the_word_was, {:word => hangman.word}),
    ].join("\n")
  end

  def in_progress_gamestate(hangman)
    [
      get_string(:you_have_lives_remaining, {:lives => hangman.score}),
      get_string(:current_guess_is, {:guess => get_guess_word(hangman)}),
      get_string(:you_have_guessed, {:guesses => hangman.guesses.join(" ")}),
    ].join("\n")
  end

  def get_guess_word(hangman)
    hangman.guessed_word.map { |letter| letter.nil? ? "_" : letter }.join
  end

  def get_string(string, args={})
    @language.get_string(string, args)
  end
end
