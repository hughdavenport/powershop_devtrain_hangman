# encoding: utf-8

class Language_fr < Language
  def initialize
    @STRINGS = {
      :pleaseenteraletter         => "S'il vous plaît entrer une lettre: ",
      :inputisnotlowercase        => "Entrée ne sont pas minuscules",
      :inputhasalreadybeenguessed => "Entrée a déjà été deviné",
      :inputisinvalid             => "Entrée est invalide",
      :gameover                   => "JEU TERMINÉ!",
      :youwon                     => "Vous avez gagné!",
      :youlost                    => "Vous avez perdu!",
      :youhavelivesremaining      => "Vous avez :lives vies restant",
      :youhadlivesremaining       => "Vous aviez :lives vies restant",
      :currentguessis             => "Conjecture actualle est: :guess",
      :finalguesswas              => "Conjecture finale était: :guess",
      :youhaveguessed             => "Vous avez deviné: :guesses",
      :youhadguessed              => "Vous aviez deviné: :guesses",
      :thewordwas                 => "Le mot était: :word",
    }
  end
end
