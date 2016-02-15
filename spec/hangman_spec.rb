require 'hangman'

RSpec.describe Hangman do
    describe "#initilize" do
        context "with a new game" do
            before do
                @game = Hangman.new
            end
            it "has a default score of 7" do
                expect(@game.score).to eq 7
            end
            it "has a default word of hangman" do
                expect(@game.word).to eq "hangman"
            end
        end
        context "with arguments" do
            it "can have a score of 6" do
                score = 6
                game = Hangman.new({:score => score})
                expect(game.score).to eq score
            end
            it "can have a word of powershop" do
                word = "powershop"
                game = Hangman.new({:word => word})
                expect(game.word).to eq word
            end
        end
    end

    describe "#won" do
        context "new game" do
            before do
                @game = Hangman.new
            end
            it "should not win on new game" do
                expect(@game.won).not_to eq true
            end
        end
    end
end
