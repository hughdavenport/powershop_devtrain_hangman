class Hangman
  attr_reader :guesses

  def initialize(starting_lives: 10, word: "hangman")
    @starting_lives = starting_lives
    @word = word
    @guesses = []
  end

  def won?
    lives > 0 && guessed_word.join() == @word
  end

  def lost?
    lives == 0
  end

  def finished?
    won? || lost?
  end

  def quit!
    @starting_lives = wrong_guesses.length
  end

  def lives
    @starting_lives - wrong_guesses.length
  end

  def wrong_guesses
    @guesses.reject { |letter| @word.include?(letter) }
  end

  def guessed_word
    @word.chars.map { |letter| letter if @guesses.include?(letter) }
  end

  def word
    @word if finished?
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
