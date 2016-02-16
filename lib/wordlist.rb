class Wordlist

    attr_reader :words

    def initialize(filename="/usr/share/dict/words")
        @words = []
        File.open(filename, "r") do |f|
            f.each_line do |line|
                line.chomp!
                next if not /^[a-z]*$/ =~ line
                next if line.length < 3 or line.length > 10
                words << line
            end
        end
        raise EOFError if @words.empty?
    end

    def get_word()
        @words.sample
    end

end
