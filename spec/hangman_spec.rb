require 'hangman'
require 'errors'

RSpec.describe Hangman do
  describe "When I start a new game" do
    context "with no arguments" do
      it "has a default score of 10" do
        expect(subject.score).to eq 10
      end

      it "has a default word of hangman" do
        expect(subject.word).to eq "hangman"
      end

      it "should not have win" do
        expect(subject).not_to be_won
      end

      it "should not have lost" do
        expect(subject).not_to be_lost
      end

      it "should not be finished" do
        expect(subject).not_to be_finished
      end

      it "should have a guessed_word of _______ (hangman)" do
        expect(subject.guessed_word).to eq ([nil]*"hangman".length)
      end
    end

    context "with an argument of default score of 6" do
      let(:score) { 6 }
      subject     { Hangman.new(score: score) }

      it "should have the correct score" do
        expect(subject.score).to eq score
      end
    end

    context "with an argument for a word of powershop" do
      let(:word) { "powershop" }
      subject    { Hangman.new(word: word) }

      it "should have the correct word" do
        expect(subject.word).to eq word
      end
    end
  end

  describe "Finishing a game" do
    context "when I have a word of testing, and guess 6 random characters" do
      let(:score)   { 7 }
      let(:word)    { "testing" }
      let(:guesses) { (('a'..'z').to_a - word.chars.to_a).sample(7) }
      subject do
        hangman = Hangman.new(score: score, word: word)
        (1..6).each do |i|
          hangman.guess(guesses[i])
        end
        hangman
      end

      it "should not have won the game" do
        expect(subject).not_to be_won
      end

      it "should not have lost .. yet" do
        expect(subject).not_to be_lost
      end

      it "should not be finished .. yet" do
        expect(subject).not_to be_finished
      end

      it "should have a score of 1" do
        expect(subject.score).to eq 1
      end

      it "should still have a guessed_word of _______ (testing)" do
        expect(subject.guessed_word).to eq ([nil]*word.length)
      end

      it "should have the correct guesses" do
        expect(subject.guesses).to eq guesses[1..6]
      end

      it "should lose next bad guess" do
        subject.guess guesses[0]
        expect(subject).to be_lost
      end

      it "should not win next bad guess" do
        subject.guess guesses[0]
        expect(subject).not_to be_won
      end

      it "should be finished with next bad guess" do
        subject.guess guesses[0]
        expect(subject).to be_finished
      end

      it "should have a score of 0 with next bad guess" do
        subject.guess guesses[0]
        expect(subject.score).to eq 0
      end

      it "should have the correct guesses after the last bad guess" do
        subject.guess guesses[0]
        expect(subject.guesses).to eq (guesses[1..6] + [guesses[0]])
      end
    end

    context "When I have a word of megaprosopous, then I make the guesses e, a, o, u, i, m, r, s, and g" do
      let(:score)   { 7 }
      let(:word)    { "megaprosopous" }
      let(:guesses) { ['e', 'a', 'o', 'u', 'i', 'm', 'r', 's', 'g'] }
      subject do
        game = Hangman.new(score: score, word: word)
        guesses.each {|guess| game.guess(guess) }
        # Just missing a p, score should be 6
        game
      end

      it "should not have won .. yet" do
        expect(subject).not_to be_won
      end

      it "should not have lost" do
        expect(subject).not_to be_lost
      end

      it "should be finished .. yet" do
        expect(subject).not_to be_finished
      end

      it "should have a score of 6 (one less than 7)" do
        expect(subject.score).to eq 6
      end

      it "should have a guessed_word of mega_roso_ous (megaprosopous)" do
        expect(subject.guessed_word).to eq (word.chars.to_a.map{|c| c == 'p' ? nil : c})
      end

      it "should have the correct guesses" do
        expect(subject.guesses).to eq guesses
      end

      it "should not win on a wrong letter" do
        subject.guess 'z'
        expect(subject).not_to be_won
      end

      it "should have the correct guesses after wrong letter" do
        subject.guess 'z'
        expect(subject.guesses).to eq (guesses + ['z'])
      end

      it "should not win on a repeat letter" do
        begin
          subject.guess 'g'
        rescue ValidateError # Ignore this, tested later
        end
        expect(subject).not_to be_won
      end

      it "should not lose on a wrong letter" do
        subject.guess 'z'
        expect(subject).not_to be_lost
      end

      it "should not lose on a repeat letter" do
        begin
          subject.guess 'g'
        rescue ValidateError # Ignore this, tested later
        end
        expect(subject).not_to be_lost
      end

      it "should win on a p" do
        subject.guess 'p'
        expect(subject).to be_won
      end

      it "should not lose on a p" do
        subject.guess 'p'
        expect(subject).not_to be_lost
      end

      it "should be finished after a p" do
        subject.guess 'p'
        expect(subject).to be_finished
      end

      it "should have a score of 6 after a p still" do
        subject.guess 'p'
        expect(subject.score).to eq 6
      end

      it "should have a guessed word of megaprosopous after a p" do
        subject.guess 'p'
        expect(subject.guessed_word).to eq word.chars.to_a
      end

      it "should have the correct guesses after a p" do
        subject.guess 'p'
        expect(subject.guesses).to eq (guesses + ['p'])
      end
    end
  end

  describe "Invalid guesses" do
    it "should not allow nil letter" do
      expect { subject.guess nil }.to raise_error(ArgumentError)
    end

    it "should not allow non strings" do
      expect { subject.guess [] }.to raise_error(ArgumentError)
    end

    it "should not allow empty letters" do
      expect { subject.guess '' }.to raise_error(NoInputError)
    end

    it "should not allow multiple letters" do
      expect { subject.guess 'aa' }.to raise_error(InputTooLongError)
    end

    it "should not allow upper case letters" do
      expect { subject.guess 'A' }.to raise_error(NotLowerCaseLetterError)
    end

    it "should not allow non alphabet letters" do
      expect { subject.guess '~' }.to raise_error(InvalidCharacterError)
    end

    it "should not allow repeat wrong guesses" do
      subject.guess 'z' # default word is hangman
      expect { subject.guess 'z' }.to raise_error(AlreadyGuessedError)
    end

    it "should not allow repeat correct guesses" do
      subject.guess 'a' # default word is hangman
      expect { subject.guess 'a' }.to raise_error(AlreadyGuessedError)
    end
  end
end
