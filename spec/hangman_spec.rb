require 'hangman'

RSpec.describe Hangman do
    describe "#score" do
        context "with a new game" do
            it "has a default score of 7" do
                default_score = 7
                game = Hangman.new
                expect(game.score).to eq default_score
            end
            it "can have a score of 6" do
                score = 6
                game = Hangman.new({:score => score})
                expect(game.score).to eq score
            end
        end
    end

    describe "#word" do
        it "has a default word of hangman" do
            default_word = "hangman"
            game = Hangman.new
            expect(game.word).to eq default_word
        end
        it "can have a word of powershop" do
            word = "powershop"
            game = Hangman.new({:word => word})
            expect(game.word).to eq word
        end
    end
end
