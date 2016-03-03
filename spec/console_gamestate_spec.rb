require 'console_gamestate'

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

  describe "#state" do
    context "Not finished" do
      before          { allow(hangman).to receive(:finished?) { false } }
      let(:gamestate) { subject.state(hangman, language) }

      it "should not have game over" do
        expect(gamestate).not_to include("[[game_over]]")
      end

      it "should not have you won" do
        expect(gamestate).not_to include("[[you_won]]")
      end

      it "should not have you lost" do
        expect(gamestate).not_to include("[[you_lost]]")
      end

      it "should have lives remaining" do
        expect(gamestate).to include("[[you_have_lives_remaining||{:lives=>#{lives}}]]")
      end

      it "should have current guess" do
        expect(gamestate).to include("[[current_guess_is||{:guess=>\"#{guess_word}\"}]]")
      end

      it "should have letters guessed" do
        expect(gamestate).to include("[[you_have_guessed||{:guesses=>\"#{guesses.join(" ")}\"}]]")
      end
    end

    context "Finished" do
      before          { allow(hangman).to receive(:finished?) { true } }
      before          { allow(hangman).to receive(:won?) { true } } # Not tested, required for gamestate call to happen
      let(:gamestate) { subject.state(hangman, language) }

      it "should have game over" do
        expect(gamestate).to include("[[game_over]]")
      end

      it "should have final lives remaining" do
        expect(gamestate).to include("[[you_had_lives_remaining||{:lives=>#{lives}}]]")
      end

      it "should have final guess" do
        expect(gamestate).to include("[[final_guess_was||{:guess=>\"#{guess_word}\"}]]")
      end

      it "should have letters guessed" do
        expect(gamestate).to include("[[you_had_guessed||{:guesses=>\"#{guesses.join(" ")}\"}]]")
      end

      it "should have actual word" do
        expect(gamestate).to include("[[the_word_was||{:word=>\"#{word}\"}]]")            # Don't include the string args, tested elsewhere
      end

      context "Won" do
        before          { allow(hangman).to receive(:won?) { true } }
        let(:gamestate) { subject.state(hangman, language) }

        it "should have you won" do
          expect(gamestate).to include("[[you_won]]")
        end

        it "should not have you lost" do
          expect(gamestate).not_to include("[[you_lost]]")
        end
      end

      context "Lost" do
        before          { allow(hangman).to receive(:won?) { false } }
        let(:gamestate) { subject.state(hangman, language) }

        it "should not have you won" do
          expect(gamestate).not_to include("[[you_won]]")
        end

        it "should have you lost" do
          expect(gamestate).to include("[[you_lost]]")
        end
      end
    end
  end
end
