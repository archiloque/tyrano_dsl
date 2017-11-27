module TyranoDsl

  # Context for parsing, used by words to store content
  class ParsingContext

    attr_reader :words

    def initialize
      @words = []
    end

    # @param word [!String]
    # @param parameters [!Hash]
    def add_word(word, parameters)
      @words << {word: word, parameters: parameters}
    end

  end
end
