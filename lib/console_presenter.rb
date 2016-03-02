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
    @io.puts(translate(error)) if error
  end

  def ask_for_letter
    message = translate(:please_enter_a_letter)
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
      translate(:game_over),
      translate(hangman.won? ? :you_won : :you_lost),
      translate(:you_had_lives_remaining, {:lives => hangman.score}),
      translate(:final_guess_was, {:guess => guessed_word(hangman)}),
      translate(:you_had_guessed, {:guesses => hangman.guesses.join(" ")}),
      translate(:the_word_was, {:word => hangman.word}),
    ].join("\n")
  end

  def in_progress_gamestate(hangman)
    [
      translate(:you_have_lives_remaining, {:lives => hangman.score}),
      translate(:current_guess_is, {:guess => guessed_word(hangman)}),
      translate(:you_have_guessed, {:guesses => hangman.guesses.join(" ")}),
    ].join("\n")
  end

  def guessed_word(hangman)
    hangman.guessed_word.map { |letter| letter.nil? ? "_" : letter }.join
  end

  def translate(string, args={})
    @language.translate(string, args)
  end
end
