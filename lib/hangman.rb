class Hangman

    attr_reader :score
    attr_reader :word
    attr_reader :guessed_word
    attr_reader :guesses

    def initialize(params={})
        @score = params.fetch(:score, 7)
        @word = params.fetch(:word, "hangman")
        @guessed_word = ("_"*@word.length)
        @guesses = []
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
        raise NoInputError if letter.empty?
        raise InputTooLongError if letter.length > 1
        raise InvalidCharacterError if not /[ -~]/ =~ letter
        raise NotLowerCaseLetterError if not ('a'..'z').include? letter
        raise AlreadyGuessedError if guesses.include? letter
    end

    def guess(letter)
        validate_letter letter
        guesses << letter
        @score -= 1 if not word.include? letter
        index = @word.index(letter)
        while not index.nil?
            @guessed_word[index] = @word[index]
            index = @word.index(letter, index + 1)
        end
    end

end
