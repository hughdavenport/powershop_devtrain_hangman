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

  def error(letter)
    raise ArgumentError if !letter.is_a?(String) || letter.empty? || letter.length > 1
    if guesses.include?(letter)
      :already_guessed
    elsif ! (letter =~ /\A[a-zA-Z]\z/)
      :invalid_character
    elsif ! ('a'..'z').include? letter
      :not_lower_case_letter
    end
  end

  def guess(letter)
    raise ValidateError if error(letter)
    guesses << letter
  end
end
