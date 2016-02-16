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

    describe "won/lost" do
        context "new game" do
            before do
                @game = Hangman.new
            end
            it "should not win on new game" do
                expect(@game).not_to be_won
            end
            it "should not lose on new game" do
                expect(@game).not_to be_lost
            end
            it "should not be finished" do
                expect(@game).not_to be_finished
            end
            it "should have a guessed_word of _______ (hangman)" do
                expect(@game.guessed_word).to eq ("_"*"hangman".length)
            end
        end
        context "almost lost game" do
            before do
                @game = Hangman.new( {:score => 7, :word => "testing"} )
                (1..6).each { @game.guess 'z' } # Word doesn't have a z in it
            end
            it "should not have won the game" do
                expect(@game).not_to be_won
            end
            it "should not have lost .. yet" do
                expect(@game).not_to be_lost
            end
            it "should not be finished .. yet" do
                expect(@game).not_to be_finished
            end
            it "should have a score of 1" do
                expect(@game.score).to eq 1
            end
            it "should still have a guessed_word of _______ (testing)" do
                expect(@game.guessed_word).to eq ("_"*"testing".length)
            end
            it "should lose next bad guess" do
                @game.guess 'z'
                expect(@game).to be_lost
            end
            it "should not win next bad guess" do
                @game.guess 'z'
                expect(@game).not_to be_won
            end
            it "should be finished with next bad guess" do
                @game.guess 'z'
                expect(@game).to be_finished
            end
        end
        context "almost winning game" do
            before do
                @game = Hangman.new( {:score => 7, :word => "megaprosopous"} )
                @game.guess 'e'
                @game.guess 'a'
                @game.guess 'o'
                @game.guess 'u'
                @game.guess 'i' # wrong, should make score 6
                @game.guess 'm'
                @game.guess 'r'
                @game.guess 's'
                @game.guess 'g'
                # Just missing a p, score should be 6
            end
            it "should not have won .. yet" do
                expect(@game).not_to be_won
            end
            it "should not have lost" do
                expect(@game).not_to be_lost
            end
            it "should be finished .. yet" do
                expect(@game).not_to be_finished
            end
            it "should have a score of 6 (one less than 7)" do
                expect(@game.score).to eq 6
            end
            it "should have a guessed_word of mega_roso_ous (megaprosopous)" do
                expect(@game.guessed_word).to eq ("megaprosopous".gsub("p", "_"))
            end
            it "should not win on a wrong letter" do
                @game.guess 'z'
                expect(@game).not_to be_won
            end
            it "should not win on a repeat letter" do
                @game.guess 'g'
                expect(@game).not_to be_won
            end
            it "should not lose on a wrong letter" do
                @game.guess 'z'
                expect(@game).not_to be_lost
            end
            it "should not lost on a repeat letter" do
                @game.guess 'g'
                expect(@game).not_to be_lost
            end
            it "should win on a p" do
                @game.guess 'p'
                expect(@game).to be_won
            end
            it "should not lose on a p" do
                @game.guess 'p'
                expect(@game).not_to be_lost
            end
            it "should be finished after a p" do
                @game.guess 'p'
                expect(@game).to be_finished
            end
            it "should have a score of 6 after a p still" do
                @game.guess 'p'
                expect(@game.score).to eq 6
            end
        end

    end
end
