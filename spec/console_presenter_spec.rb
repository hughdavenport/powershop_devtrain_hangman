require 'console_presenter'

RSpec.describe ConsolePresenter do
  context "With stubbed input and output" do
    let(:input)  { double("STDIN") }
    let(:output) do
      output = double("STDOUT")
      printed = ""
      allow(output).to receive(:print) do |text|
        printed += text
      end
      flushed = ""
      allow(output).to receive(:flush) do
        flushed += printed
        printed = ""
      end
      allow(output).to receive(:printed) { printed }
      allow(output).to receive(:flushed) { flushed }
      output
    end
    let (:io)       { ConsoleIO.new(input: input, output: output) }
    let (:language) { Language.new } # Will always just do [[:langstringhere||:argshere]] syntax, test langs seperately

    let(:error) { :testingerror }

    let(:word) { "pneumatic" }
    let(:hangman) do
      hangman = double("Hangman")
      allow(hangman).to receive(:guessed_word) { [nil]*word.length }
      allow(hangman).to receive(:score)        { 7 }
      allow(hangman).to receive(:guesses)      { [] }
      allow(hangman).to receive(:word)         { word }
      allow(hangman).to receive(:finished?)    { false }
      hangman
    end

    subject { ConsolePresenter.new(io: io, language: language) }

    describe "Error handling" do
      it "should displaying nothing when no error happend" do
        subject.display_error
        expect(output.printed).to be_empty
        expect(output.flushed).to be_empty
      end
      it "should not display the error after adding" do
        subject.add_error(error)
        expect(output.printed).to be_empty
        expect(output.flushed).to be_empty
      end
      it "should display the error we add with a new line" do
        subject.add_error(error)
        subject.display_error
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "[["+error.to_s+"]]\n"
      end
      it "should only display the error once" do
        subject.add_error(error)
        subject.display_error
        subject.display_error
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "[["+error.to_s+"]]\n"
      end
    end
    describe "Displaying game" do
      context "with no errors" do
        it "should have cleared screen, then print the gamestate" do
          subject.display_game(hangman)
          expect(output.printed).to be_empty
          expect(output.flushed).to eq "\e[H\e[2J" + subject.get_gamestate(hangman) + "\n"
        end
      end
      context "with an error" do
        it "should have cleared screen, then print the error, then print the gamestate" do
          subject.add_error(error)
          subject.display_game(hangman)
          expect(output.printed).to be_empty
          expect(output.flushed).to eq "\e[H\e[2J" + "[["+error.to_s+"]]\n" + subject.get_gamestate(hangman) + "\n"
        end
      end
    end
    describe "Asking for letters" do
      let(:letter)  { "a" }
      let(:message) { :pleaseenteraletter}
      before        { allow(input).to receive(:getch) { letter } }

      it "Should print a message asking for a letter" do
        subject.ask_for_letter
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "[["+message.to_s+"]]"
      end
      it "Should return the letter we give" do
        expect(subject.ask_for_letter).to eq letter
      end
    end
    describe "get_string" do
      let(:string)       { :teststring }
      let(:singlearg)    { {:arg1 => "arg1", :arg2 => "arg2"} }
      let(:multipleargs) { {:arg1 => "arg1", :arg2 => "arg2"} }

      it "should call the language get_string" do
        expect(subject.get_string(string)).to eq language.get_string(string)
      end
      it "should call the language get_string with a single arg" do
        expect(subject.get_string(string, singlearg)).to eq language.get_string(string, singlearg)
      end
      it "should call the language get_string with multiple args" do
        expect(subject.get_string(string, multipleargs)).to eq language.get_string(string, multipleargs)
      end
    end
    describe "get_guess_word" do
      it "should be _________ (pneumatic)" do
        expect(subject.get_guess_word(hangman)).to eq "_"*word.length
      end
    end
    describe "get_gamestate" do
      context "Not finished" do
        before          { allow(hangman).to receive(:finished?) { false } }
        let(:gamestate) { subject.get_gamestate(hangman) }

        it "should not have game over" do
          expect(gamestate).not_to include("[[gameover]]")
        end
        it "should not have you won" do
          expect(gamestate).not_to include("[[youwon]]")
        end
        it "should not have you lost" do
          expect(gamestate).not_to include("[[youlost]]")
        end

        it "should have lives remaining" do
          expect(gamestate).to include("[[youhavelivesremaining") # Don't include the string args, tested elsewhere
        end
        it "should have current guess" do
          expect(gamestate).to include("[[currentguessis")        # Don't include the string args, tested elsewhere
        end
        it "should have letters guessed" do
          expect(gamestate).to include("[[youhaveguessed")        # Don't include the string args, tested elsewhere
        end
      end
      context "Finished" do
        before          { allow(hangman).to receive(:finished?) { true } }
        before          { allow(hangman).to receive(:won?) { true } } # Not tested, required for get_gamestate call to happen
        let(:gamestate) { subject.get_gamestate(hangman) }

        it "should have game over" do
          expect(gamestate).to include("[[gameover]]")
        end

        it "should have final score (lifes remaining)" do
          expect(gamestate).to include("[[youhadlivesremaining") # Don't include the string args, tested elsewhere
        end
        it "should have final guess" do
          expect(gamestate).to include("[[finalguesswas")        # Don't include the string args, tested elsewhere
        end
        it "should have letters guessed" do
          expect(gamestate).to include("[[youhadguessed")        # don't include the string args, tested elsewhere
        end

        it "should have actual word" do
          expect(gamestate).to include("[[thewordwas")        # don't include the string args, tested elsewhere
        end

        context "Won" do
          before          { allow(hangman).to receive(:won?) { true } }
          let(:gamestate) { subject.get_gamestate(hangman) }

          it "should have you won" do
            expect(gamestate).to include("[[youwon]]")
          end
          it "should not have you lost" do
            expect(gamestate).not_to include("[[youlost]]")
          end
        end
        context "Lost" do
          before          { allow(hangman).to receive(:won?) { false } }
          let(:gamestate) { subject.get_gamestate(hangman) }

          it "should not have you won" do
            expect(gamestate).not_to include("[[youwon]]")
          end
          it "should have you lost" do
            expect(gamestate).to include("[[youlost]]")
          end
        end
      end
    end
  end
end
