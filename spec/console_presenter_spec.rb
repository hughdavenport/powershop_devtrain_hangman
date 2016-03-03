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
    let(:io)       { ConsoleIO.new(input: input, output: output) }
    let(:language) { Language.new } # Will always just do [[:langstringhere||:argshere]] syntax, test langs seperately

    let(:error) { :testingerror }

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

    let(:gamestate) do
      gamestate = double("Gamestate")
      allow(gamestate).to receive(:state) { "__gamestate__" }
      gamestate
    end

    subject { ConsolePresenter.new(io: io, language: language, gamestate: gamestate) }

    describe "Error handling" do
      it "should not display anything when no error" do
        subject.display_error
        expect(output.printed).to be_empty
        expect(output.flushed).to be_empty
      end

      it "should display the error we add with a new line" do
        subject.display_error(error)
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "[["+error.to_s+"]]\n"
      end
    end

    describe "Displaying game" do
      context "with no errors" do
        it "should have cleared screen, then print the gamestate" do
          subject.display_game(hangman)
          expect(output.printed).to be_empty
          expect(output.flushed).to eq "\e[H\e[2J" + gamestate.state(hangman, language) + "\n"
        end
      end

      context "with an error" do
        it "should have cleared screen, then print the error, then print the gamestate" do
          subject.display_game(hangman, error)
          expect(output.printed).to be_empty
          expect(output.flushed).to eq "\e[H\e[2J" + "[["+error.to_s+"]]\n" + gamestate.state(hangman, language) + "\n"
        end
      end
    end

    describe "Asking for letters" do
      let(:letter)  { "a" }
      let(:message) { :please_enter_a_letter}
      before        { allow(input).to receive(:getch) { letter } }

      it "Should print a message asking for a letter" do
        subject.ask_for_letter
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "[["+message.to_s+"]]"
      end

      it "Should return the letter we give" do
        expect(subject.getch).to eq letter
      end
    end
  end
end
