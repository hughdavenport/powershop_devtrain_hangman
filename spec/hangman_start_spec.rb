require 'hangman'

RSpec.describe Hangman, "#score" do
    context "with a new game" do
        it "has a score of 7" do
            game = Hangman.new
            expect(game.score).to eq 7
        end
    end
end
