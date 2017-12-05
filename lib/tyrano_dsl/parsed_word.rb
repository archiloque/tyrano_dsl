module TyranoDsl
  class ParsingContext

    # A parsed word
    # @attr [String] word
    # @attr [Thread::Backtrace::Location] word_location
    # @attr [Hash] parameters
    class ParsedWord
      attr_reader :word, :word_location, :parameters

      # @param [String] word
      # @param [Thread::Backtrace::Location] word_location
      # @param [Hash] parameters
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