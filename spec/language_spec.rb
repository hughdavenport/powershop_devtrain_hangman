# encoding: utf-8
require 'language_loader'
require 'errors'

RSpec.describe Language do
  context "using LanguageLoader.load" do
    context "with no arguments" do
      subject { LanguageLoader.load }

      describe "#lang" do
        it "should be english" do
          expect(subject.lang).to eq "en"
        end
      end
    end

    context "with an argument of en (English)" do
      subject { LanguageLoader.load("en") }

      describe "#lang" do
        it "should be english" do
          expect(subject.lang).to eq "en"
        end
      end

      describe "#translate" do
        it "should return the correct phrase for entering a letter" do
          expect(subject.translate(:please_enter_a_letter)).to eq "Please enter a letter: "
        end

        it "should return the correct phrase for non lower case letters" do
          expect(subject.translate(:input_is_not_lower_case)).to eq "Input is not lower case"
        end

        it "should return the correct phrase for already guessed letters" do
          expect(subject.translate(:input_has_already_been_guessed)).to eq "Input has already been guessed"
        end

        it "should return the correct phrase for invalid letters" do
          expect(subject.translate(:input_is_invalid)).to eq "Input is invalid"
        end

        it "should return the correct phrase for game over" do
          expect(subject.translate(:game_over)).to eq "GAME OVER!"
        end

        it "should return the correct phrase for winning" do
          expect(subject.translate(:you_won)).to eq "You won!"
        end

        it "should return the correct phrase for losing" do
          expect(subject.translate(:you_lost)).to eq "You lost!"
        end

        it "should return the correct phrase for lives remaining in current game, with 4 lives left" do
          expect(subject.translate(:you_have_lives_remaining, {:lives => 4})).to eq "You have 4 lives remaining"
        end

        it "should return the correct phrase for lives remaining in finished game, with 0 lives left" do
          expect(subject.translate(:you_had_lives_remaining, {:lives => 0})).to eq "You had 0 lives remaining"
        end

        it "should return the correct phrase for the current guess, with a guess of h_ngm_n" do
          expect(subject.translate(:current_guess_is, {:guess => "h_ngm_n"})).to eq "Current guess is: h_ngm_n"
        end

        it "should return the correct phrase for final guess, with a guess of hangman" do
          expect(subject.translate(:final_guess_was, {:guess => "hangman"})).to eq "Final guess was: hangman"
        end

        it "should return the correct phrase for current guess letters, with a e i o u" do
          expect(subject.translate(:you_have_guessed, {:guesses => "a e i o u"})).to eq "You have guessed: a e i o u"
        end

        it "should return the correct phrase for final guessed letters, with a b c z x y" do
          expect(subject.translate(:you_had_guessed, {:guesses => "a b c z x y"})).to eq "You had guessed: a b c z x y"
        end

        it "should return the correct phrase for the displayed word, with a word of powershop" do
          expect(subject.translate(:the_word_was, {:word => "powershop"})).to eq "The word was: powershop"
        end
      end
    end

    context "with an argument of es (Spanish)" do
      subject { LanguageLoader.load("es") }

      describe "#lang" do
        it "should be spanish" do
          expect(subject.lang).to eq "es"
        end
      end

      describe "#translate" do
        it "should return the correct phrase for entering a letter" do
          expect(subject.translate(:please_enter_a_letter)).to eq "Por favor, introduzca una letra: "
        end

        it "should return the correct phrase for non lower case letters" do
          expect(subject.translate(:input_is_not_lower_case)).to eq "La entrada no es minúscula"
        end

        it "should return the correct phrase for already guessed letters" do
          expect(subject.translate(:input_has_already_been_guessed)).to eq "De entrada ya se ha conjecturado"
        end

        it "should return the correct phrase for invalid letters" do
          expect(subject.translate(:input_is_invalid)).to eq "Entrada no es valida"
        end

        it "should return the correct phrase for game over" do
          expect(subject.translate(:game_over)).to eq "¡JUEGA TERMINADO!"
        end

        it "should return the correct phrase for winning" do
          expect(subject.translate(:you_won)).to eq "¡Ganaste!"
        end

        it "should return the correct phrase for losing" do
          expect(subject.translate(:you_lost)).to eq "¡Perdiste!"
        end

        it "should return the correct phrase for lives remaining in current game, with 4 lives left" do
          expect(subject.translate(:you_have_lives_remaining, {:lives => 4})).to eq "Usted tiene 4 vidas restante"
        end

        it "should return the correct phrase for lives remaining in finished game, with 0 lives left" do
          expect(subject.translate(:you_had_lives_remaining, {:lives => 0})).to eq "Usted tenía 0 vidas restante"
        end

        it "should return the correct phrase for the current guess, with a guess of h_ngm_n" do
          expect(subject.translate(:current_guess_is, {:guess => "h_ngm_n"})).to eq "Conjectura actual es: h_ngm_n"
        end

        it "should return the correct phrase for final guess, with a guess of hangman" do
          expect(subject.translate(:final_guess_was, {:guess => "hangman"})).to eq "Conjectura final fue: hangman"
        end

        it "should return the correct phrase for current guess letters, with a e i o u" do
          expect(subject.translate(:you_have_guessed, {:guesses => "a e i o u"})).to eq "Usted tiene adivinado: a e i o u"
        end

        it "should return the correct phrase for final guessed letters, with a b c z x y" do
          expect(subject.translate(:you_had_guessed, {:guesses => "a b c z x y"})).to eq "Usted ha adivinado: a b c z x y"
        end

        it "should return the correct phrase for the displayed word, with a word of powershop" do
          expect(subject.translate(:the_word_was, {:word => "powershop"})).to eq "La palabra fue: powershop"
        end
      end
    end

    context "with an argument of fr (French)" do
      subject { LanguageLoader.load("fr") }

      describe "#lang" do
        it "should be french" do
          expect(subject.lang).to eq "fr"
        end
      end

      describe "#translate" do
        it "should return the correct phrase for entering a letter" do
          expect(subject.translate(:please_enter_a_letter)).to eq "S'il vous plaît entrer une lettre: "
        end

        it "should return the correct phrase for non lower case letters" do
          expect(subject.translate(:input_is_not_lower_case)).to eq "Entrée ne sont pas minuscules"
        end

        it "should return the correct phrase for already guessed letters" do
          expect(subject.translate(:input_has_already_been_guessed)).to eq "Entrée a déjà été deviné"
        end

        it "should return the correct phrase for invalid letters" do
          expect(subject.translate(:input_is_invalid)).to eq "Entrée est invalide"
        end

        it "should return the correct phrase for game over" do
          expect(subject.translate(:game_over)).to eq "JEU TERMINÉ!"
        end

        it "should return the correct phrase for winning" do
          expect(subject.translate(:you_won)).to eq "Vous avez gagné!"
        end

        it "should return the correct phrase for losing" do
          expect(subject.translate(:you_lost)).to eq "Vous avez perdu!"
        end

        it "should return the correct phrase for lives remaining in current game, with 4 lives left" do
          expect(subject.translate(:you_have_lives_remaining, {:lives => 4})).to eq "Vous avez 4 vies restant"
        end

        it "should return the correct phrase for lives remaining in finished game, with 0 lives left" do
          expect(subject.translate(:you_had_lives_remaining, {:lives => 0})).to eq "Vous aviez 0 vies restant"
        end

        it "should return the correct phrase for the current guess, with a guess of h_ngm_n" do
          expect(subject.translate(:current_guess_is, {:guess => "h_ngm_n"})).to eq "Conjecture actualle est: h_ngm_n"
        end

        it "should return the correct phrase for final guess, with a guess of hangman" do
          expect(subject.translate(:final_guess_was, {:guess => "hangman"})).to eq "Conjecture finale était: hangman"
        end

        it "should return the correct phrase for current guess letters, with a e i o u" do
          expect(subject.translate(:you_have_guessed, {:guesses => "a e i o u"})).to eq "Vous avez deviné: a e i o u"
        end

        it "should return the correct phrase for final guessed letters, with a b c z x y" do
          expect(subject.translate(:you_had_guessed, {:guesses => "a b c z x y"})).to eq "Vous aviez deviné: a b c z x y"
        end

        it "should return the correct phrase for the displayed word, with a word of powershop" do
          expect(subject.translate(:the_word_was, {:word => "powershop"})).to eq "Le mot était: powershop"
        end
      end
    end

    context "with an invalid argument" do
      subject { LanguageLoader.load("invalid") }

      describe "#LanguageLoader.load" do
        it "should raise an error" do
          expect { subject }.to raise_error(NoSuchLanguageError)
        end
      end
    end
  end
end
