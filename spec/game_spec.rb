require 'game'

RSpec.describe Game do
  let(:presenter) do
    double("ConsolePresenter").tap do |presenter|
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
    end
  end

  let(:hangman) do
    double("Hangman").tap do |hangman|
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
    end
  end

  subject { Game.new(hangman: hangman, presenter: presenter) }

  describe "#run" do
    context "when there are no invalid characters" do
      let(:guesses) { ['d', 'g', 'a', 'g', 'e', 'c', 'l', 'a', 'i', 'c', 'a'] }

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
          'o', # already tested (see the hangman double)
          'X', # upper case
          '~', # invalid
          '3', # invalid
        ] + ['d', 'd', 'k', 'j', 'd', 'e', 'b', 'e', 'd', 'g', 'k']
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
