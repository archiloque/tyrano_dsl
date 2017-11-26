module TyranoDsl

  class ParsingContext

    attr_reader :words

    def initialize
      @words = []
    end

    def add_word(word, parameters)
      @words << {word: word, parameters: parameters}
    end

  end
end
