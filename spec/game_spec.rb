require 'game'

RSpec.describe Game do

  let(:presenter) do
    presenter = double("ConsolePresenter")

    displayed = false
    allow(presenter).to receive(:display_game) { displayed = true }
    allow(presenter).to receive(:displayed?) { displayed }

    asked = false
    allow(presenter).to receive(:ask_for_letter) { asked = true }
    allow(presenter).to receive(:asked?) { asked }

    has_error = false
    allow(presenter).to receive(:add_error) { has_error = true }
    allow(presenter).to receive(:has_error?) { has_error }

    presenter
  end

  let(:hangman) do
    hangman = double("Hangman")

    allow(hangman).to receive(:finished?) { false }
    allow(hangman).to receive(:validate_letter) do |letter|

    end

    hangman
  end

  subject { Game.new(hangman: hangman, presenter: presenter) }

# get_error
# get_guess
# run

end
