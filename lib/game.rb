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

  private

  def guess
    @presenter.display_game(@hangman)
    begin
      @presenter.ask_for_letter
      letter = @presenter.input_character
      break unless error(letter)
      @presenter.display_game(@hangman, error(letter))
    end while true
    letter
  end

  def error(letter)
    {
      already_guessed:       :input_has_already_been_guessed,
      invalid_character:     :input_is_invalid,
      not_lower_case_letter: :input_is_not_lower_case,
    }[@hangman.error(letter)]
  end
end
