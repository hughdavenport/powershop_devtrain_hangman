require 'wordlist'
Dir[File.dirname(__FILE__) + "/../lib/errors/*.rb"].each {|file| require file }

RSpec.describe Wordlist do
    context "default wordlist" do
        before do
            @wordlist = Wordlist.new
        end
        it "should get return a word" do
            word = @wordlist.get_word
            expect(word).not_to be_nil
            expect(word.length).to be > 0
        end
        it "should not return same word twice" do
            word1 = @wordlist.get_word
            word2 = @wordlist.get_word
            expect(word1).not_to eq word2
        end
        it "should be single line, all lower case, with no spaces" do
            word = @wordlist.get_word
            expect(word).to match /\A[a-z]*\z$/
        end
        it "should be between 4 and 15 characters" do
            word = @wordlist.get_word
            expect(word.length).to be >= 4
            expect(word.length).to be <= 15
        end
    end
    context "empty wordlist" do
        it "should fail on empty wordlist" do
            expect { Wordlist.new("/dev/null") }.to raise_error(NoUsableWordsError)
        end
    end
    context "invalid wordlist" do
        it "should fail on an invalid path" do
            expect { Wordlist.new("/nonexistantpath") }.to raise_error(NoUsableWordsError)
        end
        it "should fail on an invalid wordlist" do
            expect { Wordlist.new("tests/invalid") }.to raise_error(NoUsableWordsError)
        end
    end
    context "valid wordlist" do
        before do
            @wordlist = Wordlist.new("tests/valid")
            @words = [
                'abcd',
                'abcdefghijklmno',
            ]
        end
        it "should return a word from the wordlist" do
            word = @wordlist.get_word
            expect(@words).to include word
        end
    end
end
