module GameInitializer
  def initialize(debug: ENV.fetch("HANGMAN_DEBUG", nil),
                 word: Wordlist.new.get_word,
                 hangman: Hangman.new(word: word),
                 language: LanguageLoader.load(ENV.fetch("LANGUAGE", "en")),
                 presenter: GraphicalConsolePresenter.new(debug: debug, language: language))
    # TODO get a word based on language
    @hangman = hangman
    @presenter = presenter
  end
end
module HangmanInitializer
  def initialize(score: 10, word: "hangman")
    @starting_score = score
    @word = word
    @guesses = []
  end
end
module ConsolePresenterInitializer
  def initialize(debug: nil, io: ConsoleIO.new, language: LanguageLoader.load("en"))
    @io = io
    @language = language
    @debug = debug
  end
end
module ConsoleIOInitializer
  def initialize(input: STDIN, output: STDOUT)
    @input = input
    @output = output
  end
end
