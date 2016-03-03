require 'wordlist'
require 'errors'

RSpec.describe Wordlist do
  context "with the default initialization" do
    describe "#word" do
      it "should return a non empty word" do
        word = subject.word
        expect(word).not_to be_nil
        expect(word.length).to be > 0
      end

      it "should return a different word with a second call" do
        word1 = subject.word
        word2 = subject.word
        expect(word1).not_to eq word2
      end

      it "should return a word that only contains lower case characters" do
        word = subject.word
        expect(word).to match /\A[a-z]*\z$/
      end

      it "should return a word that is between 4 and 15 characters long" do
        word = subject.word
        expect(word.length).to be >= 4
        expect(word.length).to be <= 15
      end
    end
  end

  describe "#initialize" do
    context "with an argument of an empty wordlist" do
      subject { Wordlist.new("tests/empty") }

      it "should raise an error" do
        expect { subject }.to raise_error(NoUsableWordsError)
      end
    end

    context "with an argument of an non-existant file" do
      subject { Wordlist.new("tests/nonexistant") }

      it "should raise an exception" do
        expect { subject }.to raise_error(Exception)
      end
    end

    context "with an argument of a wordlist that only contains invalid words" do
      subject { Wordlist.new("tests/invalid") }

      it "should raise an error" do
        expect { subject }.to raise_error(NoUsableWordsError)
      end
    end

    context "with an argument of a small known wordlist" do
      let(:words) {
        [
          'abcd',
          'abcdefghijklmno',
        ]
      }
      subject { Wordlist.new("tests/valid") }

      it "should return a word from that wordlist" do
        word = subject.word
        expect(words).to include word
      end
    end
  end
end
