# encoding: utf-8

class Language_mi < Language
  private

  def strings
    super.merge({
      :please_enter_a_letter          => "Tēnā tomo hetahi rata: ",                       # Please enter one letter:
      :input_is_not_lower_case        => "e kore te tāuru pūriki",                        # Input (is) not lowercase
      :input_has_already_been_guessed => "Tāuru mea kua kētia fifili ki",                 # Input has already (been) gussed
      :input_is_invalid               => "He muhu tāuru",                                 # Invalid input
      :game_over                      => "KĒMU KI RUNGA!",                                # GAME OVER
      :you_won                        => "I riro koe!",                                   # You won!
      :you_lost                       => "I ngaro koe!",                                  # You lost!
      :you_have_lives_remaining       => "Kua koe :lives mau oraraa toe",                 # You have :lives more lives
      :you_had_lives_remaining        => "I koe :lives mau oraraa toe",                   # You have :lives more lives (no had tense?)
      :current_guess_is               => "Mana'ona'oraa ta- o nāianei ko te: :guess",     # Current guess is: :guess
      :final_guess_was                => "Mana'ona'oraa ta- whakamutunga ko te: :guess",  # Last guess is: :guess
      :you_have_guessed               => "Koe kua fifili: :guesses",                      # You have guessed: :guesses
      :you_had_guessed                => "I kua koe fifili:  :guesses",                   # You have guessed: :guesses (no had tense?)
      :the_word_was                   => "Ko te kupu a: :word",                           # The word: :word
    })
  end
end
