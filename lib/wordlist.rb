class Wordlist
  attr_reader :words

  def initialize(filename="/usr/share/dict/words")
    @words = File.readlines(filename).map { |line| line.chomp }.select { |line| line =~ /^[a-z]{4,15}$/ }
    raise NoUsableWordsError if words.empty?
  end

  def get_word
    @words.sample
  end
end
