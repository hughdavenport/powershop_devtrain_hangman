require_relative 'hangman'
require_relative 'wordlist'
require_relative 'console_presenter'
require_relative 'errors'

class Game
  def initialize(debug: ENV.fetch("HANGMAN_DEBUG", nil),
                 hangman: Hangman.new(word: Wordlist.new.word),
                 language: LanguageLoader.load(ENV.fetch("LANGUAGE", "en")),
                 presenter: ConsolePresenter.new(debug: debug, language: language))
    # TODO get a word based on language
    @hangman = hangman
    @presenter = presenter
  end

  def run
    until @hangman.finished?
      @hangman.guess(guess)
    end
    @presenter.display_game(@hangman)
  end

  def guess
    @presenter.display_game(@hangman)
    begin
      @presenter.ask_for_letter
      letter = @presenter.getch
      break unless error(letter)
      @presenter.display_game(@hangman, error(letter))
    end while true
    letter
  end

  def error(letter)
    begin
      @hangman.validate_letter(letter)
    rescue NotLowerCaseLetterError
      :input_is_not_lower_case
    rescue AlreadyGuessedError
      :input_has_already_been_guessed
    rescue ValidateError
      :input_is_invalid
    end
  end
end
