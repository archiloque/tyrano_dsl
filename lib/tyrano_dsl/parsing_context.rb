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

    # Add a parsed word
    # @param [String] word the word constant as text
    # @param [Array<Thread::Backtrace::Location>] word_location
    # @param [Hash{Symbol => Object}] parameters
    # @return [nil]
    def add_word(word, word_location, parameters)
      @words << ParsedWord.new(word, word_location, parameters)
    end

    def inspect
      "#{@words.length} words, #{@world.inspect}"
    end


  end
end
