require_relative 'hangman'
require_relative 'wordlist'
require_relative 'consolePresenter'
Dir[File.dirname(__FILE__) + "/errors/*.rb"].each {|file| require_relative file }
class Game

    def initialize()
        # TODO get a word based on language
        word = Wordlist.new.get_word
        @hangman = Hangman.new( {:word => word} )
        @presenter = ConsolePresenter.new
    end

    def run()
        lambda do
            # Loop until @hangman.won or @hangman.lost
            while not @hangman.finished?
                begin
                    # Display game
                    @presenter.display_game @hangman
                    # Read input
                    @presenter.display_error @error
                    guess = @presenter.ask_for_letter
                    # Validate input
                    if guess == "\u0003" # ctrl-c, SIGINT
                        raise Interrupt
                    end
                    if guess == "\u0004" # ctrl-d, EOF
                        # @hangman.lost
                        return
                    end
                end while not (@error = validate(guess)).nil?
                # Process input
                @hangman.guess guess
            end
        end.call
        # Clear screen, print final gamestate
        @presenter.display_game @hangman
    end

    def validate(guess)
        begin
            @hangman.validate_letter guess
        rescue NotLowerCaseLetterError
            :inputisnotlowercase
        rescue AlreadyGuessedError
            :inputhasalreadybeenguessed
        rescue ValidateError
            :inputisinvalid
        end
    end

end
