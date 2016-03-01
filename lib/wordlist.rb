class Wordlist
  attr_reader :words

  def initialize(filename="/usr/share/dict/words")
    begin
      File.open(filename, "r") do |f|
        @words = f.each_line.map { |line| line.chomp }.select { |line| line =~ /^[a-z]{4,15}$/ }
      end
    rescue IOError
    rescue Errno::ENOENT
    end
    raise NoUsableWordsError if @words.nil? || @words.empty?
  end

  def get_word()
    @words.sample
  end
end
