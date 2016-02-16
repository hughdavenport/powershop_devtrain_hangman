require 'hangman'
Dir[File.dirname(__FILE__) + "/../lib/errors/*.rb"].each {|file| require file }

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
                @guesses = (('a'..'z').to_a - "testing".chars).sample(7)
                (1..6).each do |i|
                    @game.guess @guesses[i]
                end
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
            it "should have the correct guesses" do
                expect(@game.guesses).to eq @guesses[1..6]
            end
            it "should lose next bad guess" do
                @game.guess @guesses[0]
                expect(@game).to be_lost
            end
            it "should not win next bad guess" do
                @game.guess @guesses[0]
                expect(@game).not_to be_won
            end
            it "should be finished with next bad guess" do
                @game.guess @guesses[0]
                expect(@game).to be_finished
            end
            it "should have the correct guesses after the last bad guess" do
                @game.guess @guesses[0]
                expect(@game.guesses).to eq (@guesses[1..6] + [@guesses[0]])
            end
        end
        context "almost winning game" do
            before do
                @game = Hangman.new( {:score => 7, :word => "megaprosopous"} )
                @guesses = ['e', 'a', 'o', 'u', 'i', 'm', 'r', 's', 'g']
                                            # i is wrong, should make score 6
                @guesses.each {|guess| @game.guess guess }
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
            it "should have the correct guesses" do
                expect(@game.guesses).to eq @guesses
            end
            it "should not win on a wrong letter" do
                @game.guess 'z'
                expect(@game).not_to be_won
            end
            it "should have the correct guesses after wrong letter" do
                @game.guess 'z'
                expect(@game.guesses).to eq (@guesses + ['z'])
            end
            it "should not win on a repeat letter" do
                begin
                    @game.guess 'g'
                rescue ValidateError # Ignore this, tested later
                end
                expect(@game).not_to be_won
            end
            it "should not lose on a wrong letter" do
                @game.guess 'z'
                expect(@game).not_to be_lost
            end
            it "should not lose on a repeat letter" do
                begin
                    @game.guess 'g'
                rescue ValidateError # Ignore this, tested later
                end
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
            it "should have a guessed word of megaprosopous after a p" do
                @game.guess 'p'
                expect(@game.guessed_word).to eq "megaprosopous"
            end
            it "should have the correct guesses after a p" do
                @game.guess 'p'
                expect(@game.guesses).to eq (@guesses + ['p'])
            end
        end
    end
    describe "#guess" do
        before do
            @game = Hangman.new
        end
        it "should not allow nil letter" do
            expect { @game.guess nil }.to raise_error(ValidateError)
        end
        it "should not allow non strings" do
            expect { @game.guess [] }.to raise_error(ValidateError)
        end
        it "should not allow empty letters" do
            expect { @game.guess '' }.to raise_error(ValidateError)
        end
        it "should not allow multiple letters" do
            expect { @game.guess 'aa' }.to raise_error(ValidateError)
        end
        it "should not allow upper case letters" do
            expect { @game.guess 'A' }.to raise_error(ValidateError)
        end
        it "should not allow non alphabet letters" do
            expect { @game.guess '~' }.to raise_error(ValidateError)
        end
        it "should not allow repeat wrong guesses" do
            @game.guess 'z' # default word is hangman
            expect { @game.guess 'z' }.to raise_error(ValidateError)
        end
        it "should not allow repeat correct guesses" do
            @game.guess 'a' # default word is hangman
            expect { @game.guess 'a' }.to raise_error(ValidateError)
        end
    end
end
