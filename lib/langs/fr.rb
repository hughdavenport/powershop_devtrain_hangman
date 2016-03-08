# encoding: utf-8

class Language_fr < Language
  private

  def strings
    super.merge({
      please_enter_a_letter:          "S'il vous plaît entrer une lettre: ",
      input_is_not_lower_case:        "Entrée ne sont pas minuscules",
      input_has_already_been_guessed: "Entrée a déjà été deviné",
      input_is_invalid:               "Entrée est invalide",
      game_over:                      "JEU TERMINÉ!",
      you_won:                        "Vous avez gagné!",
      you_lost:                       "Vous avez perdu!",
      you_have_lives_remaining:       "Vous avez :lives vies restant",
      you_had_lives_remaining:        "Vous aviez :lives vies restant",
      current_guess_is:               "Conjecture actualle est: :guess",
      final_guess_was:                "Conjecture finale était: :guess",
      you_have_guessed:               "Vous avez deviné: :guesses",
      you_had_guessed:                "Vous aviez deviné: :guesses",
      the_word_was:                   "Le mot était: :word",
    })
  end
end
