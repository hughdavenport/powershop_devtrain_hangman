class Hangman

    attr_reader :score
    attr_reader :word
    attr_reader :guessed_word

    def initialize(params={})
        @score = params.fetch(:score, 7)
        @word = params.fetch(:word, "hangman")
        @guessed_word = ("_"*@word.length)
    end

    def won?
        @score > 0 and @guessed_word.eql? @word
    end

    def lost?
        @score == 0
    end

    def finished?
        won? or lost?
    end

    def validate_letter(letter)
        raise ValidateError if not letter.is_a? String
        raise ValidateError if letter.length != 1
        raise ValidateError if not ('a'..'z').include? letter
    end

    def guess(letter)
        validate_letter letter
        @score -= 1 if not word.include? letter
        index = @word.index(letter)
        while not index.nil?
            @guessed_word[index] = @word[index]
            index = @word.index(letter, index + 1)
        end
    end

end
