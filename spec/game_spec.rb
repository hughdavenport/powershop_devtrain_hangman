require 'game'

RSpec.describe Game do
  let(:presenter) do
    presenter = double("ConsolePresenter")

    displayed = false
    has_error = false
    allow(presenter).to receive(:display_game) { |hangman, error| displayed = true; has_error = true if error }
    allow(presenter).to receive(:displayed?) { displayed }
    allow(presenter).to receive(:has_error?) { has_error }

    asked = 0
    allow(presenter).to receive(:ask_for_letter) {
      asked += 1
    }
    allow(presenter).to receive(:asked) { asked }
    allow(presenter).to receive(:getch) { guesses.shift } # guesses should be let'd later

    presenter
  end

  let(:hangman) do
    hangman = double("Hangman")

    guesses = 0
    allow(hangman).to receive(:guess) {|letter| guesses += 1 }
    allow(hangman).to receive(:finished?) { guesses >= 7 } # Just a testing number, real end game tested elsewhere
    allow(hangman).to receive(:guesses) { guesses }
    allow(hangman).to receive(:error) do |letter|
      # just some testing data
      if ('a'..'m').include?(letter)
        # good, always (not in real hangman object, but thats tested elsewhere
        nil
      elsif ('A'..'Z').include?(letter)
        # Obviously capital
        :not_lower_case_letter
      elsif ('n'..'z').include?(letter)
        # Pretend we've already tested this before
        :already_guessed
      elsif not /[a-zA-Z]/ =~ letter
        # Obviously not a letter
        :invalid_character
      end
    end

    hangman
  end

  subject { Game.new(hangman: hangman, presenter: presenter) }

  describe "#run" do
    context "when there are no invalid characters" do
      let(:guesses) { 0.upto(10).map { ('a'..'m').to_a.sample } }

      it "should run until finished, and consume all characters" do
        subject.run
        expect(hangman.guesses).to eq 7
        expect(presenter.asked).to eq 7
        expect(presenter.has_error?).to be false
      end
    end

    context "when there are invalid characters as well as valid characters" do
      let(:guesses) do
        [
          ('n'..'z').to_a.sample,
          ('A'..'Z').to_a.sample,
          '~',
          ('0'..'9').to_a.sample,
        ] + 0.upto(10).map { ('a'..'m').to_a.sample }
      end

      it "should loop until finished, and consume all characters, and display the correct number of errors" do
        subject.run
        expect(hangman.guesses).to eq 7
        expect(presenter.asked).to eq 11 # 4 errors
        expect(presenter.has_error?).to be true
      end
    end
  end
end
