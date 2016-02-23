require_relative 'language'
class LanguageLoader

  def self.load(lang="en")
    begin
      require_relative 'langs/' + lang
      Object.const_get('Language_' + lang).new
    rescue NameError, LoadError
      Language.new
    end
  end

end
