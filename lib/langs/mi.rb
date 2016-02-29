# encoding: utf-8
class Language_mi < Language

  def initialize
    @STRINGS = {
      :pleaseenteraletter         => "Tēnā tomo hetahi rata: ",                       # Please enter one letter:
      :inputisnotlowercase        => "e kore te tāuru pūriki",                        # Input (is) not lowercase
      :inputhasalreadybeenguessed => "Tāuru mea kua kētia fifili ki",                 # Input has already (been) gussed
      :inputisinvalid             => "He muhu tāuru",                                 # Invalid input
      :gameover                   => "KĒMU KI RUNGA!",                                # GAME OVER
      :youwon                     => "I riro koe!",                                   # You won!
      :youlost                    => "I ngaro koe!",                                  # You lost!
      :youhavelivesremaining      => "Kua koe :lives mau oraraa toe",                 # You have :lives more lives
      :youhadlivesremaining       => "I koe :lives mau oraraa toe",                   # You have :lives more lives (no had tense?)
      :currentguessis             => "Mana'ona'oraa ta- o nāianei ko te: :guess",     # Current guess is: :guess
      :finalguesswas              => "Mana'ona'oraa ta- whakamutunga ko te: :guess",  # Last guess is: :guess
      :youhaveguessed             => "Koe kua fifili: :guesses",                      # You have guessed: :guesses
      :youhadguessed              => "I kua koe fifili:  :guesses",                   # You have guessed: :guesses (no had tense?)
      :thewordwas                 => "Ko te kupu a: :word",                           # The word: :word
    }
  end

end
