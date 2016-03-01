# encoding: utf-8

class Language_es < Language
  def initialize
    @STRINGS = {
      :please_enter_a_letter          => "Por favor, introduzca una letra: ",
      :input_is_not_lower_case        => "La entrada no es minúscula",
      :input_has_already_been_guessed => "De entrada ya se ha conjecturado",
      :input_is_invalid               => "Entrada no es valida",
      :game_over                      => "¡JUEGA TERMINADO!",
      :you_won                        => "¡Ganaste!",
      :you_lost                       => "¡Perdiste!",
      :you_have_lives_remaining       => "Usted tiene :lives vidas restante",
      :you_had_lives_remaining        => "Usted tenía :lives vidas restante",
      :current_guess_is               => "Conjectura actual es: :guess",
      :final_guess_was                => "Conjectura final fue: :guess",
      :you_have_guessed               => "Usted tiene adivinado: :guesses",
      :you_had_guessed                => "Usted ha adivinado: :guesses",
      :the_word_was                   => "La palabra fue: :word",
    }
  end
end
