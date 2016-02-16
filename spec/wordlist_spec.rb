require 'wordlist'

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
        it "should be between 3 and 10 characters" do
            word = @wordlist.get_word
            expect(word.length).to be >= 3
            expect(word.length).to be <= 10
        end
    end
end
