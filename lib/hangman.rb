class Hangman

    attr_reader :score
    attr_reader :word
    attr_reader :guessed_word

    def initialize(params={})
        @score = params.fetch(:score, 7)
        @word = params.fetch(:word, "hangman")
    end

    def won()
        @score > 0 and @guessed_word.eql? @word
    end

    def lost()
        @score == 0
    end

end
