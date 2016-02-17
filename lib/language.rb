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

    def get_string(string)
        if STRINGS.include? string
            STRINGS[string]
        else
            "[[" + string.to_s + "]]"
        end
    end

end
