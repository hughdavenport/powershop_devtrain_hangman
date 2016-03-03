require 'console_presenter'

RSpec.describe ConsolePresenter do
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

  let(:ask_for_letter_message) { :please_enter_a_letter}
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

  let(:ansi_beginning_of_line) { "\e[H" }
  let(:ansi_erase_screen)      { "\e[2J" }

  subject { ConsolePresenter.new(io: io, language: language, gamestate: gamestate) }

  describe "#display_error" do
    context "with no arguments" do
      it "should not display anything" do
        subject.display_error
        expect(output.printed).to be_empty
        expect(output.flushed).to be_empty
      end
    end

    context "with a test error" do
      it "should display the error" do
        subject.display_error(error)
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "[[#{error}]]\n"
      end
    end
  end

  describe "#display_game" do
    context "with no errors" do
      it "should clear the screen, then display the gamestate" do
        subject.display_game(hangman)
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "#{ansi_beginning_of_line}#{ansi_erase_screen}" + gamestate.state(hangman, language) + "\n"
      end
    end

    context "with an error" do
      it "should clear the screen, then display the error, then display the gamestate" do
        subject.display_game(hangman, error)
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "#{ansi_beginning_of_line}#{ansi_erase_screen}" + "[[#{error}]]\n" + gamestate.state(hangman, language) + "\n"
      end
    end
  end

  describe "#ask_for_letter" do
    context "with no arguments" do
      it "Should print a message asking for a letter" do
        subject.ask_for_letter
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "[[#{ask_for_letter_message}]]"
      end
    end
  end

  describe "#getch" do
    context "when input is a single character" do
      let(:character)  { "a" }
      before           { allow(input).to receive(:getch) { character } }

      it "should return the same character" do
        expect(subject.getch).to eq character
      end
    end
  end
end
