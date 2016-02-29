require_relative 'hangman'
require_relative 'wordlist'
require_relative 'consolePresenter'
require_relative 'errors'
class Game

  include GameInitializer

  def run()
    # Loop until @hangman.won or @hangman.lost, guessing, or potentially quitting
    until @hangman.finished?
      guess = get_guess
      @hangman.guess(guess)
    end
    # Clear screen, print final gamestate
    @presenter.display_game(@hangman)
  end

  def get_guess()
    begin
      # Display game
      @presenter.display_game(@hangman)
      # Read input
      guess = @presenter.ask_for_letter
      # Validate input
      error = get_error(guess)
      break unless error
      @presenter.add_error(error)
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
