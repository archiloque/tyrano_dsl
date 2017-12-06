require_relative 'parsed_word'
require_relative 'elements/world'

module TyranoDsl

  # Context for parsing, used by words to store content
  # @attr [Array<TyranoDsl::ParsingContext::ParsedWord>] words
  # @attr [TyranoDsl::Elements::World] world
  class ParsingContext

    attr_reader :words, :base_path, :world

    def initialize(base_path, file_path)
      @base_path = base_path
      @words = []
      @world = Elements::World.new(file_path)
    end

    def inspect
      "#{@words.length} words, #{@world.inspect}"
    end


  end
end
