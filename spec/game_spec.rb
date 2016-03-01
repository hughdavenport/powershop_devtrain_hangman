require 'game'

RSpec.describe Game do
  let(:presenter) do
    presenter = double("ConsolePresenter")

    displayed = false
    allow(presenter).to receive(:display_game) { displayed = true }
    allow(presenter).to receive(:displayed?) { displayed }

    asked = 0
    allow(presenter).to receive(:ask_for_letter) {
      # guesses should be let'd later on
      asked += 1
      guesses.shift
    }
    allow(presenter).to receive(:asked) { asked }

    has_error = false
    allow(presenter).to receive(:add_error) { has_error = true }
    allow(presenter).to receive(:has_error?) { has_error }

    presenter
  end

  let(:hangman) do
    hangman = double("Hangman")

    guesses = 0
    allow(hangman).to receive(:guess) {|letter| guesses += 1 }
    allow(hangman).to receive(:finished?) { guesses >= 7 } # Just a testing number, real end game tested elsewhere
    allow(hangman).to receive(:guesses) { guesses }
    allow(hangman).to receive(:validate_letter) do |letter|
      # just some testing data
      if ('a'..'m').include?(letter)
        # good, always (not in real hangman object, but thats tested elsewhere
        nil
      elsif ('A'..'Z').include?(letter)
        # Obviously capital
        raise NotLowerCaseLetterError
      elsif ('n'..'z').include?(letter)
        # Pretend we've already tested this before
        raise AlreadyGuessedError
      elsif not /[a-zA-Z]/ =~ letter
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
        expect(presenter.asked).to eq 2
        expect(presenter).to be_displayed
      end
    end

    context "contains no error letter" do
      let(:guesses) { ['a'] }

      it "should return correct input, and not have an error" do
        expect(subject.get_guess).to eq 'a'
        expect(presenter.has_error?).to be false
        expect(presenter.asked).to eq 1
        expect(presenter).to be_displayed
      end
    end
  end

  describe "#run" do
    context "No errors" do
      let(:guesses) { 0.upto(10).map { ('a'..'m').to_a.sample } }

      it "should loop until finished" do
        subject.run
        expect(hangman.guesses).to eq 7
        expect(presenter.asked).to eq 7
        expect(presenter.has_error?).to be false
      end
    end

    context "Has errors" do
      let(:guesses) { 0.upto(4).map { ('n'..'z').to_a.sample } + 0.upto(10).map { ('a'..'m').to_a.sample } }

      it "should loop until finished, and have asked some errors" do
        subject.run
        expect(hangman.guesses).to eq 7
        expect(presenter.asked).to eq 12 # 5 errors
        expect(presenter.has_error?).to be true
      end
    end
  end
end
