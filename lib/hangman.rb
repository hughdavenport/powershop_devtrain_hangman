class Hangman
  attr_reader :guesses

  DEFAULT_STARTING_LIVES = 10

  def initialize(starting_lives: DEFAULT_STARTING_LIVES, word: "hangman")
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

  def error_message(letter)
    if guesses.include?(letter)
      :already_guessed
    elsif ! (letter =~ /\A[a-zA-Z]\z/)
      :invalid_character
    elsif ! ('a'..'z').include? letter
      :not_lower_case_letter
    end
  end

  def submit_guess(letter)
    raise ValidateError if error_message(letter)
    guesses << letter
  end
end
