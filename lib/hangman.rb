class Hangman

    attr_reader :score
    attr_reader :word

    def initialize(params={})
        @score = params.fetch(:score, 7)
        @word = params.fetch(:word, "hangman")
    end

    def won()
        @score == 0
    end

end
