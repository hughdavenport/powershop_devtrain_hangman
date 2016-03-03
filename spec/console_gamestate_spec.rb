require 'console_gamestate'
require 'language'

RSpec.describe ConsoleGamestate do
  let(:language) { Language.new } # Will always just do [[:langstringhere||:argshere]] syntax, test langs seperately
  let(:word) { "pneumatic" }
  let(:guesses) { ['c', 'p'] }
  let(:guess_word) { "p_______c" }
  let(:lives) { 7 }
  let(:hangman) do
    hangman = double("Hangman")
    allow(hangman).to receive(:guessed_word) { ['p'] + [nil]*(word.length-2) + ['c'] }
    allow(hangman).to receive(:lives)        { lives }
    allow(hangman).to receive(:guesses)      { guesses }
    allow(hangman).to receive(:word)         { word }
    allow(hangman).to receive(:finished?)    { false }
    hangman
  end

  subject { ConsoleGamestate.new.state(hangman, language) }

  context "when the game is not finished" do
    before { allow(hangman).to receive(:finished?) { false } }

    describe "#state" do
      it "should not include game over" do
        expect(subject).not_to include("[[game_over]]")
      end

      it "should not include you won" do
        expect(subject).not_to include("[[you_won]]")
      end

      it "should not include you lost" do
        expect(subject).not_to include("[[you_lost]]")
      end

      it "should include the lives remaining" do
        expect(subject).to include("[[you_have_lives_remaining||{:lives=>#{lives}}]]")
      end

      it "should include the current guess" do
        expect(subject).to include("[[current_guess_is||{:guess=>\"#{guess_word}\"}]]")
      end

      it "should include the letters guessed" do
        expect(subject).to include("[[you_have_guessed||{:guesses=>\"#{guesses.join(" ")}\"}]]")
      end
    end
  end

  context "when the game is finished" do
    before { allow(hangman).to receive(:finished?) { true } }
    before { allow(hangman).to receive(:won?) { true } } # Not tested, required for gamestate call to happen

    describe "#state" do
      it "should include game over" do
        expect(subject).to include("[[game_over]]")
      end

      it "should include the final lives remaining" do
        expect(subject).to include("[[you_had_lives_remaining||{:lives=>#{lives}}]]")
      end

      it "should include the final guess" do
        expect(subject).to include("[[final_guess_was||{:guess=>\"#{guess_word}\"}]]")
      end

      it "should include the letters guessed" do
        expect(subject).to include("[[you_had_guessed||{:guesses=>\"#{guesses.join(" ")}\"}]]")
      end

      it "should include the game word" do
        expect(subject).to include("[[the_word_was||{:word=>\"#{word}\"}]]")            # Don't include the string args, tested elsewhere
      end
    end

    context "and the game is won" do
      before { allow(hangman).to receive(:won?) { true } }

      describe "#state" do
        it "should include you won" do
          expect(subject).to include("[[you_won]]")
        end

        it "should not include you lost" do
          expect(subject).not_to include("[[you_lost]]")
        end
      end
    end

    context "and the game is lost" do
      before { allow(hangman).to receive(:won?) { false } }

      describe "#state" do
        it "should not include you won" do
          expect(subject).not_to include("[[you_won]]")
        end

        it "should include you lost" do
          expect(subject).to include("[[you_lost]]")
        end
      end
    end
  end
end
