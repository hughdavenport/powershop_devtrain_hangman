require 'consolePresenter'

RSpec.describe ConsolePresenter do
  context "With stubbed input and output" do
    let(:input)  { double("STDIN") }
    let(:output) {
      output = double("STDOUT")
      printed = ""
      allow(output).to receive(:print) { |text|
        printed += text
      }
      flushed = ""
      allow(output).to receive(:flush) {
        flushed += printed
        printed = ""
      }
      allow(output).to receive(:printed) { printed }
      allow(output).to receive(:flushed) { flushed }
      output
    }
    let (:io)       { ConsoleIO.new(input: input, output: output) }
    let (:word)     { "pneumatic" }
    let (:language) { Language.new } # Will always just do [[:langstringhere||:argshere]] syntax, test langs seperately
    let (:hangman)  { Hangman.new(word: word) }

    subject { ConsolePresenter.new(io: io, language: language) }

    describe "Error handling" do
      let(:error) { :testingerror}

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
  end
end
