class Language_es < Language

  def initialize
    @STRINGS = {
      :pleaseenteraletter         => "Por favor, introduzca una letra: ",
      :inputisnotlowercase        => "La entrada no es minúscula",
      :inputhasalreadybeenguessed => "De entrada ya se ha conjecturado",
      :inputisinvalid             => "Entrada no es valida",
      :gameover                   => "¡JUEGA TERMINADO!",
      :youwon                     => "¡Ganaste!",
      :youlost                    => "¡Perdiste!",
      :youhavelivesremaining      => "Usted tiene :lives vidas restante",
      :youhadlivesremaining       => "Usted tenía :lives vidas restante",
      :currentguessis             => "Conjectura actual es: :guess",
      :finalguesswas              => "Conjectura final fue: :guess",
      :youhaveguessed             => "Usted tiene adivinado: :guesses",
      :youhadguessed              => "Usted ha adivinado: :guesses",
      :thewordwas                 => "La palabra fue: :word",
    }
  end

end
