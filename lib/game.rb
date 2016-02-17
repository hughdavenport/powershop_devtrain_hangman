require 'hangman'
require 'wordlist'
require 'io'
require 'language'
Dir[File.dirname(__FILE__) + "/errors/*.rb"].each {|file| require file }
class Game

    attr_reader :game
    attr_reader :io
    attr_reader :language

    def initialize()
        # TODO get a word based on language
        word = Wordlist.new.get_word
        @game = Hangman.new( {:word => word} )
        @io = IO.new
        @language = Language.new ENV.fetch("LANGUAGE", "en")
    end

    def run()
        lambda do
            # Loop until @game.won or @game.lost
            while not @game.finished?
                validity = nil
                begin
                    # Clear screen
                    # Display game
                    @io.print_text_with_newline get_gamestate
                    # Read input
                    message = @language.get_string :pleaseenteraletter
                    # Was previous guess invalid?
                    @io.print_text_with_newline @language.get_string(validity) unless validity.nil?
                    @io.print_text message
                    guess = @io.get_char
                    # Echo back guess if it is printable
                    @io.print_text guess if /[ -~]/ =~ guess
                    @io.print_newline
                    # Validate input
                    if guess == "\u0003" # ctrl-c, SIGINT
                        raise Interrupt
                    end
                    if guess == "\u0004" # ctrl-d, EOF
                        # @game.lost 
                        return
                    end
                end while not (validity = validate(guess)).nil?
                # Process input
                @game.guess guess
            end
        end.call
        @io.print_text_with_newline get_gamestate
    end

    def validate(guess)
        begin
            @game.validate_letter guess
        rescue NotLowerCaseLetterError
            :inputisnotlowercase
        rescue AlreadyGuessedError
            :inputhasalreadybeenguessed
        rescue ValidateError
            :inputisinvalid
        end
    end

    def get_gamestate
        text = ""
        if @game.finished?
            text += @language.get_string :gameover
            text += "\n"
            text += @language.get_string(@game.won? ? :youwon : :youlost)
            text += "\n"
        end
        text += @language.get_string(:youhavelivesleft, {:lives => @game.score})
        text += "\n"
        text += @language.get_string(:currentguessis, {:guess => @game.guessed_word})
        text += "\n"
        text += @game.inspect + "\n"
        text
    end

end
