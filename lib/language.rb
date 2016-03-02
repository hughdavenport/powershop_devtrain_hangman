class Language
  def lang
    self.class.to_s.split("Language_")[1]
  end

  def translate(string, args={})
    if @STRINGS && @STRINGS.include?(string)
      ret = @STRINGS[string]
      args.each do |key,value|
        ret = ret.gsub(":" + key.to_s, value.to_s)
      end
      ret
    else
      "[[" + string.to_s + (args.empty? ? "" : "||" + args.to_s) + "]]"
    end
  end
end
