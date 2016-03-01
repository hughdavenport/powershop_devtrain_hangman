require_relative 'hangman'
require_relative 'wordlist'
require_relative 'console_presenter'
require_relative 'graphical_console_presenter'
require_relative 'errors'

class Game
  def initialize(debug: ENV.fetch("HANGMAN_DEBUG", nil),
                 word: Wordlist.new.get_word,
                 hangman: Hangman.new(word: word),
                 language: LanguageLoader.load(ENV.fetch("LANGUAGE", "en")),
                 presenter: GraphicalConsolePresenter.new(debug: debug, language: language))
    # TODO get a word based on language
    @hangman = hangman
    @presenter = presenter
  end

  def run
    # Loop until @hangman.won or @hangman.lost, guessing, or potentially quitting
    until @hangman.finished?
      guess = get_guess
      @hangman.guess(guess)
    end
    # Clear screen, print final gamestate
    @presenter.display_game(@hangman)
  end

  def get_guess
    @presenter.display_game(@hangman)
    begin
      guess = @presenter.ask_for_letter
      error = get_error(guess)
      break unless error
      @presenter.display_game(@hangman, error)
    end while true
    guess
  end

  def get_error(guess)
    begin
      @hangman.validate_letter(guess)
    rescue NotLowerCaseLetterError
      :inputisnotlowercase
    rescue AlreadyGuessedError
      :inputhasalreadybeenguessed
    rescue ValidateError
      :inputisinvalid
    end
  end
end
