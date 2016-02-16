class Language

    attr_reader :lang

    def initialize(lang="en")
        @lang = lang
        begin
            load File.dirname(__FILE__) + '/langs/' + @lang + ".rb"
        rescue LoadError
            raise NoSuchLanguageError
        end
    end

    def get_string(string)
        if STRINGS.include? string
            STRINGS[string]
        else
            "[[" + string.to_s + "]]"
        end
    end

end
