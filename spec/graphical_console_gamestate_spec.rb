require 'language'
require 'graphical_console_gamestate'

RSpec.describe GraphicalConsoleGamestate do
  let(:language) { Language.new } # Will always just do [[:langstringhere||:argshere]] syntax, test langs seperately
  let(:word) { "pneumatic" }
  let(:guesses) { ['c', 'p'] }
  let(:guess_word) { "p_______c" }
  let(:lives) { 7 }
  let(:hangman) do
    double("Hangman").tap do |hangman|
      allow(hangman).to receive(:guessed_word) { ['p'] + [nil]*(word.length-2) + ['c'] }
      allow(hangman).to receive(:lives)        { lives }
      allow(hangman).to receive(:guesses)      { guesses }
      allow(hangman).to receive(:word)         { word }
      allow(hangman).to receive(:finished?)    { false }
    end
  end

  let(:parent_state) { ConsoleGamestate.new.state(hangman, language) }
  subject            { GraphicalConsoleGamestate.new.state(hangman, language) }

  let(:empty_picture) do
    <<EOF



















EOF
  end

  let(:missing_pole_picture) do
    <<EOF


















-----------
EOF
  end

  let(:missing_beam_picture) do
    <<EOF
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  let(:missing_support_picture) do
    <<EOF
     +------------
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  let(:missing_rope_picture) do
    <<EOF
     +------------
     |  /
     | /
     |/
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  let(:missing_head_picture) do
    <<EOF
     +-----------+
     |  /        |
     | /         |
     |/
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  let(:missing_torso_picture) do
    <<EOF
     +-----------+
     |  /        |
     | /        _|_
     |/        /   \\
     |        |     |
     |        |     |
     |         \\___/
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  let(:missing_both_arms_picture) do
    <<EOF
     +-----------+
     |  /        |
     | /        _|_
     |/        /   \\
     |        |     |
     |        |     |
     |         \\___/
     |           |
     |           |
     |           |
     |           |
     |           |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  let(:missing_both_legs_picture) do
    <<EOF
     +-----------+
     |  /        |
     | /        _|_
     |/        /   \\
     |        |     |
     |        |     |
     |         \\___/
     |           |
     |           |
     |       ----+----
     |           |
     |           |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  let(:missing_right_leg_picture) do
    <<EOF
     +-----------+
     |  /        |
     | /        _|_
     |/        /   \\
     |        |     |
     |        |     |
     |         \\___/
     |           |
     |           |
     |       ----+----
     |           |
     |           |
     |           ^
     |          /
     |         /
     |        /
     |       /
     |
-----+-----
EOF
  end

  let(:game_over_picture) do
    <<EOF
     +-----------+
     |  /        |
     | /        _|_
     |/        /   \\
     |        |     |
     |        |     |
     |         \\___/
     |           |
     |           |
     |       ----+----
     |           |
     |           |
     |           ^
     |          / \\
     |         /   \\
     |        /     \\
     |       /       \\
     |
-----+-----
EOF
  end

  context "when the game is not finished" do
    before { allow(hangman).to receive(:finished?) { false } }

    describe "#state" do
      it "should start with the parent class #state method" do
        expect(subject).to start_with parent_state
      end
    end

    context "with 10 lives left" do
      let(:lives) { 10 }

      describe "#state" do
        it "should end with an empty hangman picture" do
          expect(subject).to end_with empty_picture
        end
      end
    end

    context "with 9 lives left" do
      let(:lives) { 9 }

      describe "#state" do
        it "should end with a hangman with only a base" do
          expect(subject).to end_with missing_pole_picture
        end
      end
    end

    context "with 8 lives left" do
      let(:lives) { 8 }

      describe "#state" do
        it "should end with a hangman with only a base and a pole" do
          expect(subject).to end_with missing_beam_picture
        end
      end
    end

    context "with 7 lives left" do
      let(:lives) { 7 }

      describe "#state" do
        it "should end with a hangman with only a base, pole, and top beam" do
          expect(subject).to end_with missing_support_picture
        end
      end
    end

    context "with 6 lives left" do
      let(:lives) { 6 }

      describe "#state" do
        it "should end with a hangman with only a base, pole, top beam, and support beam (hanging structure)" do
          expect(subject).to end_with missing_rope_picture
        end
      end
    end

    context "with 5 lives left" do
      let(:lives) { 5 }

      describe "#state" do
        it "should end with a hangman with a hanging structure and a rope" do
          expect(subject).to end_with missing_head_picture
        end
      end
    end

    context "with 4 lives left" do
      let(:lives) { 4 }

      describe "#state" do
        it "should end with a hangman with a hanging structure and a rope with a head" do
          expect(subject).to end_with missing_torso_picture
        end
      end
    end

    context "with 3 lives left" do
      let(:lives) { 3 }

      describe "#state" do
        it "should end with a hangman with a hangman without legs or arms" do
          expect(subject).to end_with missing_both_arms_picture
        end
      end
    end

    context "with 2 lives left" do
      let(:lives) { 2 }

      describe "#state" do
        it "should end with a hangman with a hangman without legs" do
          expect(subject).to end_with missing_both_legs_picture
        end
      end
    end

    context "with 1 lives left" do
      let(:lives) { 1 }

      describe "#state" do
        it "should end with a hangman with a hangman without a right leg" do
          expect(subject).to end_with missing_right_leg_picture
        end
      end
    end
  end

  context "when the game is finished" do
    before { allow(hangman).to receive(:finished?) { false } }

    context "if the game is won" do
      before { allow(hangman).to receive(:won?) { true } }

      describe "#state" do
        it "should start with the parent class #state method" do
          expect(subject).to start_with parent_state
        end
      end

      context "with 10 lives left" do
        let(:lives) { 10 }

        describe "#state" do
          it "should end with an empty hangman picture" do
            expect(subject).to end_with empty_picture
          end
        end
      end

      context "with 9 lives left" do
        let(:lives) { 9 }

        describe "#state" do
          it "should end with a hangman with only a base" do
            expect(subject).to end_with missing_pole_picture
          end
        end
      end

      context "with 8 lives left" do
        let(:lives) { 8 }

        describe "#state" do
          it "should end with a hangman with only a base and a pole" do
            expect(subject).to end_with missing_beam_picture
          end
        end
      end

      context "with 7 lives left" do
        let(:lives) { 7 }

        describe "#state" do
          it "should end with a hangman with only a base, pole, and top beam" do
            expect(subject).to end_with missing_support_picture
          end
        end
      end

      context "with 6 lives left" do
        let(:lives) { 6 }

        describe "#state" do
          it "should end with a hangman with only a base, pole, top beam, and support beam (hanging structure)" do
            expect(subject).to end_with missing_rope_picture
          end
        end
      end

      context "with 5 lives left" do
        let(:lives) { 5 }

        describe "#state" do
          it "should end with a hangman with a hanging structure and a rope" do
            expect(subject).to end_with missing_head_picture
          end
        end
      end

      context "with 4 lives left" do
        let(:lives) { 4 }

        describe "#state" do
          it "should end with a hangman with a hanging structure and a rope with a head" do
            expect(subject).to end_with missing_torso_picture
          end
        end
      end

      context "with 3 lives left" do
        let(:lives) { 3 }

        describe "#state" do
          it "should end with a hangman with a hangman without legs or arms" do
            expect(subject).to end_with missing_both_arms_picture
          end
        end
      end

      context "with 2 lives left" do
        let(:lives) { 2 }

        describe "#state" do
          it "should end with a hangman with a hangman without legs" do
            expect(subject).to end_with missing_both_legs_picture
          end
        end
      end

      context "with 1 lives left" do
        let(:lives) { 1 }

        describe "#state" do
          it "should end with a hangman with a hangman without a right leg" do
            expect(subject).to end_with missing_right_leg_picture
          end
        end
      end
    end

    context "if the game is lost" do
      before { allow(hangman).to receive(:won?) { false } }
      let(:lives) { 0 }

      describe "#state" do
        it "should start with the parent class #state method" do
          expect(subject).to start_with parent_state
        end

        it "should have a full hangman" do
          expect(subject).to end_with game_over_picture
        end
      end
    end
  end
end
