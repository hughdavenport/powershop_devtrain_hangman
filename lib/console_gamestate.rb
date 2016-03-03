class ConsoleGamestate
  def state(hangman, language)
    gamestate = if hangman.finished?
      finished_state(hangman, language)
    else
      in_progress_state(hangman, language)
    end
    gamestate += hangman.inspect if @debug
    gamestate
  end

  private

  def finished_state(hangman, language)
    [
      language.translate(:game_over),
      language.translate(hangman.won? ? :you_won : :you_lost),
      language.translate(:you_had_lives_remaining, {:lives => hangman.lives}),
      language.translate(:final_guess_was, {:guess => guessed_word(hangman)}),
      language.translate(:you_had_guessed, {:guesses => hangman.guesses.join(" ")}),
      language.translate(:the_word_was, {:word => hangman.word}),
    ].join("\n")
  end

  def in_progress_state(hangman, language)
    [
      language.translate(:you_have_lives_remaining, {:lives => hangman.lives}),
      language.translate(:current_guess_is, {:guess => guessed_word(hangman)}),
      language.translate(:you_have_guessed, {:guesses => hangman.guesses.join(" ")}),
    ].join("\n")
  end

  def guessed_word(hangman)
    hangman.guessed_word.map { |letter| letter.nil? ? "_" : letter }.join
  end
end