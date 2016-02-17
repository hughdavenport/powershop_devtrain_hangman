class Hangman

    attr_reader :word
    attr_reader :guesses

    def initialize(params={})
        @starting_score = params.fetch(:score, 7)
        @word = params.fetch(:word, "hangman")
        @guesses = []
    end

    def won?
        score > 0 and guessed_word.eql? @word
    end

    def lost?
        score == 0
    end

    def finished?
        won? or lost?
    end

    def score
        @starting_score - (guesses - guessed_word.chars).length
    end

    def guessed_word
        ret = "_"*@word.length
        guesses.each do |letter|
            next if not @word.include? letter
            index = @word.index(letter)
            while not index.nil?
                ret[index] = @word[index]
                index = @word.index(letter, index + 1)
            end
        end
        ret
    end

    def validate_letter(letter)
        raise InvalidTypeError if not letter.is_a? String
        raise NoInputError if letter.empty?
        raise InputTooLongError if letter.length > 1
        raise InvalidCharacterError if not /[a-zA-Z]/ =~ letter
        raise NotLowerCaseLetterError if not ('a'..'z').include? letter
        raise AlreadyGuessedError if guesses.include? letter
    end

    def guess(letter)
        validate_letter letter
        guesses << letter
    end

end
