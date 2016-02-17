require 'Language'
Dir[File.dirname(__FILE__) + "/../lib/errors/*.rb"].each {|file| require file }

RSpec.describe Language do
    context "default" do
        before do
            @language = Language.new
        end
        it "should default to english" do
            expect(@language.lang).to eq "en"
        end
    end
    context "English" do
        before do
            @language = Language.new "en"
        end
        it "should return the correct phrase for entering a letter" do
            expect(@language.get_string(:pleaseenteraletter)).to eq "Please enter a letter: "
        end
        it "should return the correct phrase for non lower case letters" do
            expect(@language.get_string(:inputisnotlowercase)).to eq "Input is not lower case"
        end
        it "should return the correct phrase for already guessed letters" do
            expect(@language.get_string(:inputhasalreadybeenguessed)).to eq "Input has already been guessed"
        end
        it "should return the correct phrase for invalid letters" do
            expect(@language.get_string(:inputisinvalid)).to eq "Input is invalid"
        end
        it "should return the correct phrase for game over" do
            expect(@language.get_string(:gameover)).to eq "GAME OVER!"
        end
        it "should return the correct phrase for winning" do
            expect(@language.get_string(:youwon)).to eq "You won!"
        end
        it "should return the correct phrase for losing" do
            expect(@language.get_string(:youlost)).to eq "You lost!"
        end
        it "should return the correct phrase for lives remaining in current game, with 4 lives left" do
            expect(@language.get_string(:youhavelivesremaining, {:lives => 4})).to eq "You have 4 lives remaining"
        end
        it "should return the correct phrase for lives remaining in finished game, with 0 lives left" do
            expect(@language.get_string(:youhadlivesremaining, {:lives => 0})).to eq "You had 0 lives remaining"
        end
        it "should return the correct phrase for the current guess, with a guess of h_ngm_n" do
            expect(@language.get_string(:currentguessis, {:guess => "h_ngm_n"})).to eq "Current guess is: h_ngm_n"
        end
        it "should return the correct phrase for final guess, with a guess of hangman" do
            expect(@language.get_string(:finalguesswas, {:guess => "hangman"})).to eq "Final guess was: hangman"
        end
        it "should return the correct phrase for current guess letters, with a e i o u" do
            expect(@language.get_string(:youhaveguessed, {:guesses => "a e i o u"})).to eq "You have guessed: a e i o u"
        end
        it "should return the correct phrase for final guessed letters, with a b c z x y" do
            expect(@language.get_string(:youhadguessed, {:guesses => "a b c z x y"})).to eq "You had guessed: a b c z x y"
        end
    end
end
