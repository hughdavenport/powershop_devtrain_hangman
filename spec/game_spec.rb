require 'game'

RSpec.describe Game do

  let(:presenter) do
    presenter = double("ConsolePresenter")

    displayed = false
    allow(presenter).to receive(:display_game) { displayed = true }
    allow(presenter).to receive(:displayed?) { displayed }

    asked = false
    allow(presenter).to receive(:ask_for_letter) { asked = true }
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

# get_guess
# run

end
