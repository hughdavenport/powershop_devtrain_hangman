class Language

    attr_reader :lang

    def initialize(lang="en")
        @lang = lang
        begin
            require_relative 'langs/' + @lang
        rescue LoadError
            raise NoSuchLanguageError
        end
    end

    def get_string(string, args={})
        if STRINGS.include? string
            ret = STRINGS[string]
            args.each do |key,value|
                ret = ret.gsub(":" + key.to_s, value.to_s)
            end
            ret
        else
            "[[" + string.to_s + (args.empty? ? "" : "||" + args.to_s) + "]]"
        end
    end

end
