require 'consoleIO'

RSpec.describe ConsoleIO do
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
    subject      { ConsoleIO.new(input: input, output: output) }

    describe "get_char" do
      it "Should raise interrupt with ctrl-c" do
        allow(input).to receive(:getch) { "\u0003" }
        expect { subject.get_char }.to raise_error(Interrupt)
      end
      it "Should raise EOF with ctrl-d" do
        allow(input).to receive(:getch) { "\u0004" }
        expect { subject.get_char }.to raise_error(EOFError)
      end
      it "Should return the input" do
        allow(input).to receive(:getch) { "a" }
        expect(subject.get_char).to eq "a"
      end
      it "Should return input in order" do
        i = 0;
        chars = ('a'..'z').to_a.sample(5)
        allow(input).to receive(:getch) { i+=1 if i < 5; chars[i-1]; }
        expect(subject.get_char).to eq chars[0]
        expect(subject.get_char).to eq chars[1]
        expect(subject.get_char).to eq chars[2]
        expect(subject.get_char).to eq chars[3]
        expect(subject.get_char).to eq chars[4]
      end
    end
    describe "print_test" do
      it "should print and flush test" do
        subject.print_text("test")
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "test"
      end
    end
    describe "print_newline" do
      it "should print and flush a newline" do
        subject.print_newline
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "\n"
      end
    end
    describe "print_text_with_newline" do
      it "should print test with a newline and flush" do
        subject.print_text_with_newline("test")
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "test\n"
      end
    end
    describe "clear_screen" do
      it "should have the beginning of line then erase screen ANSI sequences flushed" do
        subject.clear_screen
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "\e[H\e[2J"
      end
    end
  end
end
