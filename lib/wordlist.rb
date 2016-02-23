class Wordlist

  attr_reader :words

  def initialize(filename="/usr/share/dict/words")
    @words = []
    begin
      File.open(filename, "r") do |f|
        f.each_line do |line|
          line.chomp!
          next if not /^[a-z]*$/ =~ line
          next if line.length < 4 or line.length > 15
          words << line
        end
      end
    rescue IOError
    rescue Errno::ENOENT
    end
    raise NoUsableWordsError if @words.empty?
  end

  def get_word()
    @words.sample
  end

end
