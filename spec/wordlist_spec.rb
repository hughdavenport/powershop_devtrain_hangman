require 'wordlist'
require 'errors'

RSpec.describe Wordlist do
  context "default wordlist" do
    it "should get return a word" do
      word = subject.get_word
      expect(word).not_to be_nil
      expect(word.length).to be > 0
    end

    it "should not return same word twice" do
      word1 = subject.get_word
      word2 = subject.get_word
      expect(word1).not_to eq word2
    end

    it "should be single line, all lower case, with no spaces" do
      word = subject.get_word
      expect(word).to match /\A[a-z]*\z$/
    end

    it "should be between 4 and 15 characters" do
      word = subject.get_word
      expect(word.length).to be >= 4
      expect(word.length).to be <= 15
    end
  end

  context "empty wordlist file" do
    subject { Wordlist.new("/dev/null") }

    it "should fail on empty wordlist" do
      expect { subject }.to raise_error(NoUsableWordsError)
    end
  end

  context "invalid wordlist path" do
    subject { Wordlist.new("/nonexistantpath") }

    it "should fail on an invalid path" do
      expect { subject }.to raise_error(Exception)
    end
  end

  context "invalid wordlist file" do
    subject { Wordlist.new("tests/invalid") }

    it "should fail on an invalid wordlist" do
      expect { subject }.to raise_error(NoUsableWordsError)
    end
  end

  context "valid wordlist file" do
    let(:words) {
      [
        'abcd',
        'abcdefghijklmno',
      ]
    }
    subject { Wordlist.new("tests/valid") }

    it "should return a word from the wordlist" do
      word = subject.get_word
      expect(words).to include word
    end
  end
end
