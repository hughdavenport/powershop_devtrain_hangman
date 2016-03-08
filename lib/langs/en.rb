class Language_en < Language
  private

  def strings
    super.merge({
      please_enter_a_letter:          "Please enter a letter: ",
      input_is_not_lower_case:        "Input is not lower case",
      input_has_already_been_guessed: "Input has already been guessed",
      input_is_invalid:               "Input is invalid",
      game_over:                      "GAME OVER!",
      you_won:                        "You won!",
      you_lost:                       "You lost!",
      you_have_lives_remaining:       "You have :lives lives remaining",
      you_had_lives_remaining:        "You had :lives lives remaining",
      current_guess_is:               "Current guess is: :guess",
      final_guess_was:                "Final guess was: :guess",
      you_have_guessed:               "You have guessed: :guesses",
      you_had_guessed:                "You had guessed: :guesses",
      the_word_was:                   "The word was: :word",
    })
  end
end
