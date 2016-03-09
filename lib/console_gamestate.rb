class ConsoleGamestate
  def state(hangman, language, debug=false)
    [
      if hangman.finished?
        finished_state(hangman, language)
      else
        in_progress_state(hangman, language)
      end,
      debug_state(hangman, language, debug),
      extra_state(hangman, language, debug),
    ].select { |entry| entry }.join("\n")
  end

  protected

  def debug_state(hangman, language, debug)
    hangman.inspect if debug
  end

  def extra_state(hangman, language, debug)

  end

  private

  def finished_state(hangman, language)
    [
      language.translate(:game_over),
      language.translate(hangman.won? ? :you_won : :you_lost),
      language.translate(:you_had_lives_remaining, lives: hangman.lives),
      language.translate(:final_guess_was, guess: word_guessed_so_far(hangman)),
      language.translate(:you_had_guessed, guesses: hangman.guesses.join(" ")),
      language.translate(:the_word_was, word: hangman.word),
    ].join("\n")
  end

  def in_progress_state(hangman, language)
    [
      language.translate(:you_have_lives_remaining, lives: hangman.lives),
      language.translate(:current_guess_is, guess: word_guessed_so_far(hangman)),
      language.translate(:you_have_guessed, guesses: hangman.guesses.join(" ")),
    ].join("\n")
  end

  def word_guessed_so_far(hangman)
    hangman.word_guessed_so_far.map { |letter| letter.nil? ? "_" : letter }.join
  end
end
