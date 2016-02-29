module GameInitializer
  def initialize(params={})
    debug = params.fetch(:debug, ENV.fetch("HANGMAN_DEBUG", nil))
    word = params.fetch(:word, Wordlist.new.get_word)
    hangman = params.fetch(:hangman, Hangman.new({:word => word}))
    language = params.fetch(:language, LanguageLoader.load(ENV.fetch("LANGUAGE", "en")))
    presenter = params.fetch(:presenter, ConsolePresenter.new({:debug => debug, :language => language}))
    # TODO get a word based on language

    @hangman = hangman
    @presenter = presenter
  end
end
module HangmanInitializer
  def initialize(params={})
    score = params.fetch(:score, 10)
    word = params.fetch(:word, "hangman")
    @starting_score = score
    @word = word
    @guesses = []
  end
end
module ConsolePresenterInitializer
  def initialize(params={})
    debug = params.fetch(:debug, nil)
    io = params.fetch(:io, ConsoleIO.new)
    language = params.fetch(:language, LanguageLoader.load("en"))

    @io = io
    @language = language
    @debug = debug
  end
end
module ConsoleIOInitializer
  def initialize(params={})
    input = params.fetch(:input, STDIN)
    output = params.fetch(:output, STDOUT)

    @input = input
    @output = output
  end
end
