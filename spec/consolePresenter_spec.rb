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
    let (:language) { Language.new } # Will always just do [[:langstringhere||:argshere]] syntax, test langs seperately

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
    context "In a new game" do
      let (:word)     { "pneumatic" }
      let (:hangman)  { Hangman.new(word: word) }

      describe "get_guess_word" do
        it "should be _________ (pneumatic)" do
          expect(subject.get_guess_word(hangman)).to eq "_"*word.length
        end
      end
    end
  end
end
