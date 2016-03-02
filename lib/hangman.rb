class Hangman
  attr_reader :word
  attr_reader :guesses

  def initialize(score: 10, word: "hangman")
    @starting_score = score
    @word = word
    @guesses = []
  end

  def won?
    score > 0 && guessed_word.join() == @word
  end

  def lost?
    score == 0
  end

  def finished?
    won? || lost?
  end

  def score
    @starting_score - wrong_guesses.length
  end

  def wrong_guesses
    guesses.reject { |letter| letter if @word.include?(letter) }
  end

  def guessed_word
    @word.chars.map { |letter| letter if guesses.include?(letter) }
  end

  def validate_letter(letter)
    raise ArgumentError if not letter.is_a? String
    raise NoInputError if letter.empty?
    raise InputTooLongError if letter.length > 1
    raise InvalidCharacterError if not /[a-zA-Z]/ =~ letter
    raise NotLowerCaseLetterError if not ('a'..'z').include? letter
    raise AlreadyGuessedError if guesses.include? letter
  end

  def guess(letter)
    validate_letter(letter)
    guesses << letter
  end
end
