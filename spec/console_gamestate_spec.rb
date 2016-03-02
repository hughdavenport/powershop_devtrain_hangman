require 'console_gamestate'

RSpec.describe ConsoleGamestate do
  let(:language) { Language.new } # Will always just do [[:langstringhere||:argshere]] syntax, test langs seperately
  let(:word) { "pneumatic" }
  let(:hangman) do
    hangman = double("Hangman")
    allow(hangman).to receive(:guessed_word) { ['p'] + [nil]*(word.length-1) }
    allow(hangman).to receive(:lives)        { 7 }
    allow(hangman).to receive(:guesses)      { ['p'] }
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
        expect(gamestate).to include("[[you_have_lives_remaining") # Don't include the string args, tested elsewhere
      end

      it "should have current guess" do
        expect(gamestate).to include("[[current_guess_is")         # Don't include the string args, tested elsewhere
      end

      it "should have letters guessed" do
        expect(gamestate).to include("[[you_have_guessed")         # Don't include the string args, tested elsewhere
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
        expect(gamestate).to include("[[you_had_lives_remaining") # Don't include the string args, tested elsewhere
      end

      it "should have final guess" do
        expect(gamestate).to include("[[final_guess_was")         # Don't include the string args, tested elsewhere
      end

      it "should have letters guessed" do
        expect(gamestate).to include("[[you_had_guessed")         # Don't include the string args, tested elsewhere
      end

      it "should have actual word" do
        expect(gamestate).to include("[[the_word_was")            # Don't include the string args, tested elsewhere
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

  describe "#guessed_word" do
    it "should be p________ (pneumatic)" do
      expect(subject.guessed_word(hangman)).to eq "p"+"_"*(word.length-1)
    end
  end
end
