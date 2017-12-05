require_relative 'elements/world'

module TyranoDsl

  # Context for parsing, used by words to store content
  # @attr [!Array<TyranoDsl::ParsingContext::ParsedWord>] words
  # @attr [!TyranoDsl::Elements::World] world
  class ParsingContext

    attr_reader :words, :base_path, :world

    def initialize(base_path, file_path)
      @base_path = base_path
      @words = []
      @world = Elements::World.new(file_path)
    end

    # @param [!String] word
    # @param [Thread::Backtrace::Location] word_location
    # @param [!Hash] parameters
    def add_word(word, word_location, parameters)
      @words << ParsedWord.new(word, word_location, parameters)
    end

    def inspect
      "#{@words.length} words, #{@world.inspect}"
    end


    # @attr [!String] word
    # @attr [Thread::Backtrace::Location] word_location
    # @attr [!Hash] parameters
    class ParsedWord

      attr_reader :word, :word_location, :parameters

      # @param [!String] word
      # @param [Thread::Backtrace::Location] word_location
      # @param [!Hash] parameters
      def initialize(word, word_location, parameters)
        @word = word
        @word_location = word_location
        @parameters = parameters
      end

      def to_s
        "l#{word_location.lineno} #{word} #{parameters}"
      end


    end

  end
end
