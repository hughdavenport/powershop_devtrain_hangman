require 'game'

RSpec.describe Game do

  let(:presenter) do
    presenter = double("ConsolePresenter")

    displayed = false
    allow(presenter).to receive(:display_game) { displayed = true }
    allow(presenter).to receive(:displayed?) { displayed }

    asked = false
    allow(presenter).to receive(:ask_for_letter) {
      # guesses should be let'd later on
      asked = true
      guesses.shift
    }
    allow(presenter).to receive(:asked?) { asked }

    has_error = false
    allow(presenter).to receive(:add_error) { has_error = true }
    allow(presenter).to receive(:has_error?) { has_error }

    presenter
  end

  let(:hangman) do
    hangman = double("Hangman")

    allow(hangman).to receive(:finished?) { false }
    allow(hangman).to receive(:validate_letter) do |letter|
      # just some testing data
      if letter == 'a'
        # good, always (not in real hangman object, but thats tested elsewhere
        nil
      elsif letter == 'A'
        # Obviously capital
        raise NotLowerCaseLetterError
      elsif letter == 'z'
        # Pretend we've already tested this before
        raise AlreadyGuessedError
      elsif letter == '~' || letter == '1'
        # Obviously not a letter
        raise ValidateError
      end
    end

    hangman
  end

  subject { Game.new(hangman: hangman, presenter: presenter) }

  describe "#get_error" do
    it "should fail on a capital letter" do
      expect(subject.get_error('A')).to eq :inputisnotlowercase
    end
    it "should fail on an already guessed letter" do
      expect(subject.get_error('z')).to eq :inputhasalreadybeenguessed
    end
    it "should fail on a tilde as invalid" do
      expect(subject.get_error('~')).to eq :inputisinvalid
    end
    it "should fail on a digit as invalid" do
      expect(subject.get_error('1')).to eq :inputisinvalid
    end
    it "should accept a 'valid' letter" do
      expect(subject.get_error('a')).to be_nil
    end
  end

  describe "#get_guess" do
    context "contains error letter" do
      let(:guesses) { ['A', 'a'] }
      it "should get an error, loop again, then return the valid input" do
        expect(subject.get_guess).to eq 'a'
        expect(presenter.has_error?).to be true
        expect(presenter).to be_asked
        expect(presenter).to be_displayed
      end
    end
    context "contains no error letter" do
      let(:guesses) { ['a'] }
      it "should return correct input, and not have an error" do
        expect(subject.get_guess).to eq 'a'
        expect(presenter.has_error?).to be false
        expect(presenter).to be_asked
        expect(presenter).to be_displayed
      end
    end
  end

# run

end
