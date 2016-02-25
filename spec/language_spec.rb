# encoding: utf-8
require 'languageLoader'
require 'errors'

RSpec.describe Language do
  context "default" do
    subject { LanguageLoader.load }
    it "should default to english" do
      expect(subject.lang).to eq "en"
    end
  end
  context "English" do
    subject { LanguageLoader.load("en") }

    it "should return the correct phrase for entering a letter" do
      expect(subject.get_string(:pleaseenteraletter)).to eq "Please enter a letter: "
    end
    it "should return the correct phrase for non lower case letters" do
      expect(subject.get_string(:inputisnotlowercase)).to eq "Input is not lower case"
    end
    it "should return the correct phrase for already guessed letters" do
      expect(subject.get_string(:inputhasalreadybeenguessed)).to eq "Input has already been guessed"
    end
    it "should return the correct phrase for invalid letters" do
      expect(subject.get_string(:inputisinvalid)).to eq "Input is invalid"
    end
    it "should return the correct phrase for game over" do
      expect(subject.get_string(:gameover)).to eq "GAME OVER!"
    end
    it "should return the correct phrase for winning" do
      expect(subject.get_string(:youwon)).to eq "You won!"
    end
    it "should return the correct phrase for losing" do
      expect(subject.get_string(:youlost)).to eq "You lost!"
    end
    it "should return the correct phrase for lives remaining in current game, with 4 lives left" do
      expect(subject.get_string(:youhavelivesremaining, {:lives => 4})).to eq "You have 4 lives remaining"
    end
    it "should return the correct phrase for lives remaining in finished game, with 0 lives left" do
      expect(subject.get_string(:youhadlivesremaining, {:lives => 0})).to eq "You had 0 lives remaining"
    end
    it "should return the correct phrase for the current guess, with a guess of h_ngm_n" do
      expect(subject.get_string(:currentguessis, {:guess => "h_ngm_n"})).to eq "Current guess is: h_ngm_n"
    end
    it "should return the correct phrase for final guess, with a guess of hangman" do
      expect(subject.get_string(:finalguesswas, {:guess => "hangman"})).to eq "Final guess was: hangman"
    end
    it "should return the correct phrase for current guess letters, with a e i o u" do
      expect(subject.get_string(:youhaveguessed, {:guesses => "a e i o u"})).to eq "You have guessed: a e i o u"
    end
    it "should return the correct phrase for final guessed letters, with a b c z x y" do
      expect(subject.get_string(:youhadguessed, {:guesses => "a b c z x y"})).to eq "You had guessed: a b c z x y"
    end
  end
  context "Spanish" do
    subject { LanguageLoader.load("es") }

    it "should return the correct phrase for entering a letter" do
      expect(subject.get_string(:pleaseenteraletter)).to eq "Por favor, introduzca una letra: "
    end
    it "should return the correct phrase for non lower case letters" do
      expect(subject.get_string(:inputisnotlowercase)).to eq "La entrada no es minúscula"
    end
    it "should return the correct phrase for already guessed letters" do
      expect(subject.get_string(:inputhasalreadybeenguessed)).to eq "De entrada ya se ha conjecturado"
    end
    it "should return the correct phrase for invalid letters" do
      expect(subject.get_string(:inputisinvalid)).to eq "Entrada no es valida"
    end
    it "should return the correct phrase for game over" do
      expect(subject.get_string(:gameover)).to eq "¡JUEGA TERMINADO!"
    end
    it "should return the correct phrase for winning" do
      expect(subject.get_string(:youwon)).to eq "¡Ganaste!"
    end
    it "should return the correct phrase for losing" do
      expect(subject.get_string(:youlost)).to eq "¡Perdiste!"
    end
    it "should return the correct phrase for lives remaining in current game, with 4 lives left" do
      expect(subject.get_string(:youhavelivesremaining, {:lives => 4})).to eq "Usted tiene 4 vidas restante"
    end
    it "should return the correct phrase for lives remaining in finished game, with 0 lives left" do
      expect(subject.get_string(:youhadlivesremaining, {:lives => 0})).to eq "Usted tenía 0 vidas restante"
    end
    it "should return the correct phrase for the current guess, with a guess of h_ngm_n" do
      expect(subject.get_string(:currentguessis, {:guess => "h_ngm_n"})).to eq "Conjectura actual es: h_ngm_n"
    end
    it "should return the correct phrase for final guess, with a guess of hangman" do
      expect(subject.get_string(:finalguesswas, {:guess => "hangman"})).to eq "Conjectura final fue: hangman"
    end
    it "should return the correct phrase for current guess letters, with a e i o u" do
      expect(subject.get_string(:youhaveguessed, {:guesses => "a e i o u"})).to eq "Usted tiene adivinado: a e i o u"
    end
    it "should return the correct phrase for final guessed letters, with a b c z x y" do
      expect(subject.get_string(:youhadguessed, {:guesses => "a b c z x y"})).to eq "Usted ha adivinado: a b c z x y"
    end
  end
  context "French" do
    subject { LanguageLoader.load("fr") }

    it "should return the correct phrase for entering a letter" do
      expect(subject.get_string(:pleaseenteraletter)).to eq "S'il vous plaît entrer une lettre: "
    end
    it "should return the correct phrase for non lower case letters" do
      expect(subject.get_string(:inputisnotlowercase)).to eq "Entrée ne sont pas minuscules"
    end
    it "should return the correct phrase for already guessed letters" do
      expect(subject.get_string(:inputhasalreadybeenguessed)).to eq "Entrée a déjà été deviné"
    end
    it "should return the correct phrase for invalid letters" do
      expect(subject.get_string(:inputisinvalid)).to eq "Entrée est invalide"
    end
    it "should return the correct phrase for game over" do
      expect(subject.get_string(:gameover)).to eq "JEU TERMINÉ!"
    end
    it "should return the correct phrase for winning" do
      expect(subject.get_string(:youwon)).to eq "Vous avez gagné!"
    end
    it "should return the correct phrase for losing" do
      expect(subject.get_string(:youlost)).to eq "Vous avez perdu!"
    end
    it "should return the correct phrase for lives remaining in current game, with 4 lives left" do
      expect(subject.get_string(:youhavelivesremaining, {:lives => 4})).to eq "Vous avez 4 vies restant"
    end
    it "should return the correct phrase for lives remaining in finished game, with 0 lives left" do
      expect(subject.get_string(:youhadlivesremaining, {:lives => 0})).to eq "Vous aviez 0 vies restant"
    end
    it "should return the correct phrase for the current guess, with a guess of h_ngm_n" do
      expect(subject.get_string(:currentguessis, {:guess => "h_ngm_n"})).to eq "Conjecture actualle est: h_ngm_n"
    end
    it "should return the correct phrase for final guess, with a guess of hangman" do
      expect(subject.get_string(:finalguesswas, {:guess => "hangman"})).to eq "Conjecture finale était: hangman"
    end
    it "should return the correct phrase for current guess letters, with a e i o u" do
      expect(subject.get_string(:youhaveguessed, {:guesses => "a e i o u"})).to eq "Vous avez deviné: a e i o u"
    end
    it "should return the correct phrase for final guessed letters, with a b c z x y" do
      expect(subject.get_string(:youhadguessed, {:guesses => "a b c z x y"})).to eq "Vous aviez deviné: a b c z x y"
    end
  end
end
