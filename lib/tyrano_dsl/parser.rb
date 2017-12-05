require 'logger'

require_relative 'tyrano_exception'
require_relative 'vocabulary'

TyranoDsl::Vocabulary::ALL_WORDS.each do |word|
  require_relative "words/#{word}"
end


module TyranoDsl

  # Parse the DSL
  class Parser
    include TyranoDsl::Vocabulary

    # @param [TyranoDsl::ParsingContext] parsing_context
    def initialize(parsing_context)
      @logger = Logger.new(STDOUT)
      @words = {
          DECLARE_BACKGROUND => ::TyranoDsl::Words::DeclareBackground.new,
          DECLARE_CHARACTER => ::TyranoDsl::Words::DeclareCharacter.new,
          DISPLAY_TEXT => ::TyranoDsl::Words::DisplayText.new,
          JUMP_TO => ::TyranoDsl::Words::JumpTo.new,
          SET_BACKGROUND => ::TyranoDsl::Words::SetBackground.new,
          SET_CHARACTER_STANCE => ::TyranoDsl::Words::SetCharacterStance.new,
          SHOW_CHARACTER => ::TyranoDsl::Words::ShowCharacter.new,
          START_SCENE => ::TyranoDsl::Words::StartScene.new,
      }

      @words.each_pair do |word, word_implementation|
        # Avoid warning in tests if we redefine an existing method
        unless self.class.method_defined? word
          self.class.send(:define_method, word) do |*parameters|
            current_location = caller_locations(1, 1).first
            log {"l#{current_location.lineno} [#{word}] parameters are #{parameters}"}
            word_implementation.parse(parsing_context, current_location, parameters)
          end
        end
      end
    end

    def method_missing(symbol, *args)
      current_location = caller_locations(1, 1).first
      raise ::TyranoDsl::TyranoException, "Line #{current_location.lineno} unknown word [#{symbol}], available words are: #{ ALL_WORDS.join(', ')}"
    end

    private

    def log
      @logger.info(self.class) {yield}
    end

  end
end
