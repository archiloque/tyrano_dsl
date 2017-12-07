require 'logger'

require_relative 'parsed_word'
require_relative 'tyrano_exception'
require_relative 'vocabulary'

TyranoDsl::Vocabulary::ALL_WORDS.each do |word|
  require_relative "parsing_words/#{word}"
end


module TyranoDsl

  # Parse the DSL
  # @attr [TyranoDsl::ParsingContext] context
  # @attr [Array<Thread::Backtrace::Location>] word_location
  class Parser

    attr_reader :context
    attr_accessor :word_location

    # Add all the words
    {
        TyranoDsl::Vocabulary::DECLARE_BACKGROUND => ::TyranoDsl::ParsingWords::DeclareBackground,
        TyranoDsl::Vocabulary::DECLARE_CHARACTER => ::TyranoDsl::ParsingWords::DeclareCharacter,
        TyranoDsl::Vocabulary::DISPLAY_TEXT => ::TyranoDsl::ParsingWords::DisplayText,
        TyranoDsl::Vocabulary::JUMP_TO => ::TyranoDsl::ParsingWords::JumpTo,
        TyranoDsl::Vocabulary::SET_BACKGROUND => ::TyranoDsl::ParsingWords::SetBackground,
        TyranoDsl::Vocabulary::SET_CHARACTER_STANCE => ::TyranoDsl::ParsingWords::SetCharacterStance,
        TyranoDsl::Vocabulary::SHOW_CHARACTER => ::TyranoDsl::ParsingWords::ShowCharacter,
        TyranoDsl::Vocabulary::START_SCENE => ::TyranoDsl::ParsingWords::StartScene,
    }.each do |word, word_module|
      include word_module

      # Patch the method to store the location when a word is called
      symbol_word = word.to_sym
      old_method = instance_method(symbol_word)
      define_method(symbol_word) do |*args|
        self.word_location = caller_locations
        old_method.bind(self).call(*args)
      end
    end

    # @param [TyranoDsl::ParsingContext] parsing_context
    def initialize(parsing_context)
      @logger = Logger.new(STDOUT)
      @context = parsing_context
    end

    protected

    # Add a parsed word
    # @param [String] word
    # @param [Hash{String => Object}] parameters
    # @return [void]
    def add_parsed_word(word, parameters)
      context.words << TyranoDsl::ParsedWord.new(
          word,
          word_location,
          parameters
      )
    end

    private

    def log
      @logger.info(self.class) {yield}
    end

  end
end
