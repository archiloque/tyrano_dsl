require_relative 'vocabulary'
require_relative 'words/declare_scene'

module TyranoDsl
  class Reader
    include TyranoDsl::Vocabulary

    def initialize(context)
      p 'Reading begin'
      @words = {
        DECLARE_SCENE => ::TyranoDsl::Words::DeclareScene.new
      }

      words.each_pair do |word, word_implementation|
        self.class.send(:define_method, word) do |*parameters|
          p "Word [#{word}] parameters are #{parameters}"
          word_implementation.parse(context, parameters)
        end
      end
      p 'Reading end'
    end

    def method_missing(symbol, *args)
      raise "Unknown word [#{symbol}], available words are: #{@words.keys.sort.join(', ')}"
    end
  end
end
