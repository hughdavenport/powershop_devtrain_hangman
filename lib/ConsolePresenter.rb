require 'ConsoleIO'
class ConsolePresenter

    def initialize(params)
        @io = ConsoleIO.new
        @language = Language.new params.fetch(:language, "en")
    end

    def display_game(hangman)
        @io.clear_screen
        @io.print_text_with_newline get_gamestate(hangman)
    end

    def display_error(error)
        @io.print_text_with_newline @language.get_string(error) unless error.nil?
    end

    def ask_for_letter
        message = @language.get_string :pleaseenteraletter
        @io.print_text message
        @io.get_char
    end

    def get_gamestate(hangman)
        text = ""
        if hangman.finished?
            text += @language.get_string :gameover
            text += "\n"
            text += @language.get_string(hangman.won? ? :youwon : :youlost)
            text += "\n"
            text += @language.get_string(:youhadlivesremaining, {:lives => hangman.score})
            text += "\n"
            text += @language.get_string(:finalguesswas, {:guess => hangman.guessed_word})
            text += "\n"
            text += @language.get_string(:youhadguessed, {:guesses => hangman.guesses.join(" ")})
            text += "\n"
        else
            text += @language.get_string(:youhavelivesremaining, {:lives => hangman.score})
            text += "\n"
            text += @language.get_string(:currentguessis, {:guess => hangman.guessed_word})
            text += "\n"
            text += @language.get_string(:youhaveguessed, {:guesses => hangman.guesses.join(" ")})
            text += "\n"
        end
        text += hangman.inspect + "\n"
        text
    end

end