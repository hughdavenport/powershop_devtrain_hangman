class Wordlist
  attr_reader :words

  def initialize(filename="/usr/share/dict/words")
    @words = File.open(filename, "r") do |f|
      f.each_line.map { |line| line.chomp }.select { |line| line =~ /^[a-z]{4,15}$/ }
    end
    raise NoUsableWordsError if @words.nil? || @words.empty?
  end

  def get_word
    @words.sample
  end
end
