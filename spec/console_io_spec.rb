require 'console_io'

RSpec.describe ConsoleIO do
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

  let(:ctrl_c) { "\u0003" }
  let(:ctrl_d) { "\u0004" }

  let(:ansi_beginning_of_line) { "\e[H" }
  let(:ansi_erase_screen)      { "\e[2J" }

  subject { ConsoleIO.new(input: input, output: output) }

  describe "#getch" do
    context "when input is ctrl-c" do
      before { allow(input).to receive(:getch) { ctrl_c } }

      it "should raise an interrupt error" do
        expect { subject.getch }.to raise_error(Interrupt)
      end
    end

    context "when input is ctrl-d" do
      before { allow(input).to receive(:getch) { ctrl_d } }

      it "should raise an EOFError" do
        expect { subject.getch }.to raise_error(EOFError)
      end
    end

    context "when input is a single character" do
      let(:character) { "a" }
      before { allow(input).to receive(:getch) { character } }

      it "should return the same letter" do
        expect(subject.getch).to eq character
      end
    end

    context "when input is a series of characters" do
      let(:chars) { ["a", "e", "w", "l", "o"] }
      before do
        i = 0
        allow(input).to receive(:getch) { i+=1 if i < 5; chars[i-1]; }
      end

      it "should return the same characters in the correct order" do
        chars.each { |character| expect(subject.getch).to eq character }
      end
    end
  end

  describe "#print" do
    context "when printing a test message" do
      let(:to_print) { "test" }

      it "should print the message then flush" do
        subject.print(to_print)
        expect(output.printed).to be_empty
        expect(output.flushed).to eq to_print
      end
    end
  end

  describe "#puts" do
    context "when printing a test message" do
      let(:to_print) { "test" }
      it "should print the message with a newline then flush" do
        subject.puts(to_print)
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "#{to_print}\n"
      end
    end

    context "with no arguments" do
      it "should print and flush a newline" do
        subject.puts
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "\n"
      end
    end
  end

  describe "#clear_screen" do
    context "with no arguments" do
      it "should print the beginning of line then erase screen ANSI sequences then flush" do
        subject.clear_screen
        expect(output.printed).to be_empty
        expect(output.flushed).to eq "#{ansi_beginning_of_line}#{ansi_erase_screen}"
      end
    end
  end
end
