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
    let (:language) { Language.new } # Will always just do [[:langstringhere||:argshere]] syntax
    let (:hangman)  { Hangman.new(word: word) }

    subject { ConsolePresenter.new(io: io) }

    describe "Error handling" do
      it "should displaying nothing when no error happend" do
        subject.display_error
        expect(output.printed).to be_empty
        expect(output.flushed).to be_empty
      end
    end
  end
end
