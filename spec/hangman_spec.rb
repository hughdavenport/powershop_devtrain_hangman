require 'hangman'
require 'errors'

RSpec.describe Hangman do
  describe "#initialize" do
    context "with no arguments" do
      let(:lives) { 10 }
      let(:word)  { "hangman" }

      describe "the game" do
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_finished }
      end

      describe "#word (after quitting so that it is visible)" do
        before { subject.quit! }

        it "should be the default" do
          expect(subject.word).to eq word
        end
      end

      describe "#lives" do
        it "should be the default" do
          expect(subject.lives).to eq lives
        end
      end

      describe "#word_guessed_so_far" do
        it "should be empty" do
          expect(subject.word_guessed_so_far).to eq ([nil]*word.length)
        end
      end
    end

    context "with an argument for the starting lives" do
      let(:lives) { 6 }
      subject     { Hangman.new(starting_lives: lives) }

      describe "#lives" do
        it "should be correct" do
          expect(subject.lives).to eq lives
        end
      end
    end

    context "with an argument for the word" do
      let(:word) { "powershop" }
      subject    { Hangman.new(word: word) }

      describe "#word (after quitting so that it is visible)" do
        before { subject.quit! }

        it "should be correct" do
          expect(subject.word).to eq word
        end
      end
    end
  end

  context "when I am one turn off losing, with no correct guesses" do
    let(:lives)   { 7 }
    let(:word)    { "testing" }
    let(:guesses) { ['v', 'a', 'c', 'u', 'z', 'k'] }
    let(:correct) { 'e' }
    subject       { Hangman.new(starting_lives: lives, word: word) }
    before        { guesses.each { |guess| subject.submit_guess(guess) } }

    describe "the game" do
      it { is_expected.not_to be_won }
      it { is_expected.not_to be_lost }
      it { is_expected.not_to be_finished }
    end

    describe "#word" do
      it "should be hidden" do
        expect(subject.word).to be_nil
      end
    end

    describe "#lives" do
      it "should be 1" do
        expect(subject.lives).to eq 1
      end
    end

    describe "#word_guessed_so_far" do
      it "should be empty" do
        expect(subject.word_guessed_so_far).to eq ([nil]*word.length)
      end
    end

    describe "#guesses" do
      it "should have the guesses I supplied" do
        expect(subject.guesses).to eq guesses
      end
    end

    context "then I make one more incorrect guess" do
      let(:guess) { 'o' }
      before      { subject.submit_guess(guess) }

      describe "the game" do
        it { is_expected.to be_lost }
        it { is_expected.not_to be_won }
        it { is_expected.to be_finished }
      end

      describe "#word" do
        it "should now be visible" do
          expect(subject.word).to eq word
        end
      end

      describe "#lives" do
        it "should be 0" do
          expect(subject.lives).to eq 0
        end
      end

      describe "#guesses" do
        it "should have both the original guesses, and the final guess" do
          expect(subject.guesses).to eq (guesses + [guess])
        end
      end
    end

    context "then I make a correct guess" do
      let(:guess) { correct }
      before      { subject.submit_guess(guess) }

      describe "the game" do
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_finished }
      end

      describe "#word" do
        it "should be hidden" do
          expect(subject.word).to be_nil
        end
      end

      describe "#lives" do
        it "should be 1" do
          expect(subject.lives).to eq 1
        end
      end

      describe "#guesses" do
        it "should have both the original guesses, and the final guess" do
          expect(subject.guesses).to eq (guesses + [guess])
        end
      end
    end
  end

  context "when I an one turn off winning, with one incorrect guess" do
    let(:lives)   { 7 }
    let(:word)    { "megaprosopous" }
    let(:guesses) { ['e', 'a', 'o', 'u', 'i', 'm', 'r', 's', 'g'] } # Just missing a p, and i is incorrect
    subject       { Hangman.new(starting_lives: lives, word: word) }
    before        { guesses.each { |guess| subject.submit_guess(guess) } }

    let(:missing_letter) { 'p' }

    describe "the game" do
      it { is_expected.not_to be_lost }
      it { is_expected.not_to be_won }
      it { is_expected.not_to be_finished }
    end

    describe "#word" do
      it "should be hidden" do
        expect(subject.word).to be_nil
      end
    end

    describe "#lives" do
      it "should be 6" do
        expect(subject.lives).to eq 6
      end
    end

    describe "#word_guessed_so_far" do
      it "should be correct" do
        expect(subject.word_guessed_so_far).to eq (word.chars.to_a.map { |character| character unless character == missing_letter })
      end
    end

    describe "#guesses" do
      it "should have the guesses I supplied" do
        expect(subject.guesses).to eq guesses
      end
    end

    context "then I make another incorrect guess" do
      let(:guess) { 'z' }
      before      { subject.submit_guess(guess) }

      describe "the game" do
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_finished }
      end

      describe "#word" do
        it "should be hidden" do
          expect(subject.word).to be_nil
        end
      end

      describe "#lives" do
        it "should be 5" do
          expect(subject.lives).to eq 5
        end
      end

      describe "#word_guessed_so_far" do
        it "should be correct" do
          expect(subject.word_guessed_so_far).to eq (word.chars.to_a.map { |character| character unless character == missing_letter })
        end
      end

      describe "#guesses" do
        it "should have the guesses I supplied, including the new guess" do
          expect(subject.guesses).to eq guesses + [guess]
        end
      end
    end

    context "then I make a repeat guess" do
      let(:guess) { 'g' }
      before { expect { subject.submit_guess(guess) }.to raise_error(ValidateError) }

      describe "the game" do
        it { is_expected.not_to be_lost }
        it { is_expected.not_to be_won }
        it { is_expected.not_to be_finished }
      end

      describe "#word" do
        it "should be hidden" do
          expect(subject.word).to be_nil
        end
      end

      describe "#lives" do
        it "should be 6" do
          expect(subject.lives).to eq 6
        end
      end

      describe "#word_guessed_so_far" do
        it "should be correct" do
          expect(subject.word_guessed_so_far).to eq (word.chars.to_a.map { |character| character unless character == missing_letter })
        end
      end

      describe "#guesses" do
        it "should have the only the original guesses I supplied" do
          expect(subject.guesses).to eq guesses
        end
      end
    end

    context "then I make the last correct guess" do
      let(:guess) { 'p' }
      before      { subject.submit_guess(guess) }

      describe "the game" do
        it { is_expected.not_to be_lost }
        it { is_expected.to be_won }
        it { is_expected.to be_finished }
      end

      describe "#word" do
        it "should now be visible" do
          expect(subject.word).to eq word
        end
      end

      describe "#lives" do
        it "should be 6" do
          expect(subject.lives).to eq 6
        end
      end

      describe "#guesses" do
        it "should have both the original guesses, and the final guess" do
          expect(subject.guesses).to eq (guesses + [guess])
        end
      end

      describe "#word_guessed_so_far" do
        it "should be the same as the final word" do
          expect(subject.word_guessed_so_far).to eq word.chars.to_a
        end
      end
    end
  end

  describe "#error_message" do
    context "with an upper case character argument" do
      let(:guess) { 'A' }
      let(:error) { :not_lower_case_letter }

      it "should return the correct error message" do
        expect(subject.error_message(guess)).to be error
      end
    end

    context "with a non alphabet character argument" do
      let(:guess) { '~' }
      let(:error) { :invalid_character }

      it "should return the correct error message" do
        expect(subject.error_message(guess)).to be error
      end
    end

    context "with a repeated incorrect guess as an argument" do
      let(:guess) { 'z' }
      let(:error) { :already_guessed }
      before      { subject.submit_guess(guess) }

      it "should return the correct error message" do
        expect(subject.error_message(guess)).to be error
      end
    end

    context "with a repeated correct guess as an argument" do
      let(:guess) { 'a' }
      let(:error) { :already_guessed }
      before      { subject.submit_guess(guess) }

      it "should return the correct error message" do
        expect(subject.error_message(guess)).to be error
      end
    end
  end

  describe "#submit_guess" do
    context "with an argument of nil" do
      let(:guess) { nil }

      it "should raise an validate error" do
        expect { subject.submit_guess(guess) }.to raise_error(ValidateError)
      end
    end

    context "with a non string argument" do
      let(:guess) { [] }

      it "should raise an validate error" do
        expect { subject.submit_guess(guess) }.to raise_error(ValidateError)
      end
    end

    context "with an empty string argument" do
      let(:guess) { '' }

      it "should raise an validate error" do
        expect { subject.submit_guess(guess) }.to raise_error(ValidateError)
      end
    end

    context "with a multiple character string argument" do
      let(:guess) { 'aa' }

      it "should raise an validate error" do
        expect { subject.submit_guess(guess) }.to raise_error(ValidateError)
      end
    end

    context "with an upper case character argument" do
      let(:guess) { 'A' }

      it "should raise a validate error" do
        expect { subject.submit_guess(guess) }.to raise_error(ValidateError)
      end
    end

    context "with a non alphabet character argument" do
      let(:guess) { '~' }

      it "should raise a validate error" do
        expect { subject.submit_guess(guess) }.to raise_error(ValidateError)
      end
    end

    context "with a repeated incorrect guess argument" do
      let(:guess) { 'z' }
      before      { subject.submit_guess(guess) }

      it "should raise a validate error" do
        expect { subject.submit_guess(guess) }.to raise_error(ValidateError)
      end
    end

    context "with a repeated correct guess argument" do
      let(:guess) { 'a' }
      before      { subject.submit_guess(guess) }

      it "should raise a validate error" do
        expect { subject.submit_guess(guess) }.to raise_error(ValidateError)
      end
    end
  end
end
