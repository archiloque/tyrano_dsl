require 'logger'

require_relative 'tyrano_exception'
require_relative 'vocabulary'

TyranoDsl::Vocabulary::ALL_WORDS.each do |word|
  require_relative "words/#{word}"
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
        TyranoDsl::Vocabulary::DECLARE_BACKGROUND => ::TyranoDsl::Words::DeclareBackground,
        TyranoDsl::Vocabulary::DECLARE_CHARACTER => ::TyranoDsl::Words::DeclareCharacter,
        TyranoDsl::Vocabulary::DISPLAY_TEXT => ::TyranoDsl::Words::DisplayText,
        TyranoDsl::Vocabulary::JUMP_TO => ::TyranoDsl::Words::JumpTo,
        TyranoDsl::Vocabulary::SET_BACKGROUND => ::TyranoDsl::Words::SetBackground,
        TyranoDsl::Vocabulary::SET_CHARACTER_STANCE => ::TyranoDsl::Words::SetCharacterStance,
        TyranoDsl::Vocabulary::SHOW_CHARACTER => ::TyranoDsl::Words::ShowCharacter,
        TyranoDsl::Vocabulary::START_SCENE => ::TyranoDsl::Words::StartScene,
    }.each do |word, word_module|
      include word_module

      # Patch the method to store the location
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
    
    private

    def log
      @logger.info(self.class) {yield}
    end

  end
end
