require 'hangman'

RSpec.describe Hangman, "#score" do
    context "with a new game" do
        it "has a default score of 7" do
            default_score = 7
            game = Hangman.new
            expect(game.score).to eq default_score
        end
        it "can have a score of 6" do
            score = 6
            game = Hangman.new(score)
            expect(game.score).to eq score
        end
    end
end
