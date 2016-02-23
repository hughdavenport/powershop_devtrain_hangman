class Language_en < Language

  def initialize
    @STRINGS = {
      :pleaseenteraletter         => "Please enter a letter: ",
      :inputisnotlowercase        => "Input is not lower case",
      :inputhasalreadybeenguessed => "Input has already been guessed",
      :inputisinvalid             => "Input is invalid",
      :gameover                   => "GAME OVER!",
      :youwon                     => "You won!",
      :youlost                    => "You lost!",
      :youhavelivesremaining      => "You have :lives lives remaining",
      :youhadlivesremaining       => "You had :lives lives remaining",
      :currentguessis             => "Current guess is: :guess",
      :finalguesswas              => "Final guess was: :guess",
      :youhaveguessed             => "You have guessed: :guesses",
      :youhadguessed              => "You had guessed: :guesses",
      :thewordwas                 => "The word was: :word",
    }
  end

end
