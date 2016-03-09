require_relative 'hangman'
require_relative 'wordlist'
require_relative 'console_presenter'
require_relative 'errors'

class Game
  ERROR_MAPPINGS = {
    already_guessed:       :input_has_already_been_guessed,
    invalid_character:     :input_is_invalid,
    not_lower_case_letter: :input_is_not_lower_case,
  }

  def initialize(hangman: Hangman.new(word: Wordlist.new.word),
                 presenter: ConsolePresenter.new)
    # TODO get a word based on language
    @hangman = hangman
    @presenter = presenter
  end

  def run
    until @hangman.finished?
      @hangman.submit_guess(guess)
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
    ERROR_MAPPINGS[@hangman.error_message(letter)]
  end
end
