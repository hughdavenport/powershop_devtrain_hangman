require_relative 'language'
require_relative 'langs/en'
require_relative 'langs/es'
require_relative 'langs/fr'

class LanguageLoader
  LANGUAGES = {
    en: Language_en.new,
    es: Language_es.new,
    fr: Language_fr.new,
  }

  def self.load(lang="en")
    LANGUAGES.fetch(lang.to_sym) { raise NoSuchLanguageError }
  end
end
