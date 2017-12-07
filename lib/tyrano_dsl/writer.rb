require 'logger'

require_relative 'writing_context'
require_relative 'elements_writers/background_writer'
require_relative 'elements_writers/character_writer'

require_relative 'vocabulary'
TyranoDsl::Vocabulary::ALL_WORDS.each do |word|
  require_relative "writing_words/#{word}"
end

module TyranoDsl

  # Write the content that have been parsed
  class Writer

    include TyranoDsl::Vocabulary

    def initialize
      @logger = Logger.new(STDOUT)
      @words = {
          DECLARE_BACKGROUND => ::TyranoDsl::WritingWords::DeclareBackground.new,
          DECLARE_CHARACTER => ::TyranoDsl::WritingWords::DeclareCharacter.new,
          DISPLAY_TEXT => ::TyranoDsl::WritingWords::DisplayText.new,
          JUMP_TO => ::TyranoDsl::WritingWords::JumpTo.new,
          SET_BACKGROUND => ::TyranoDsl::WritingWords::SetBackground.new,
          SET_CHARACTER_STANCE => ::TyranoDsl::WritingWords::SetCharacterStance.new,
          SHOW_CHARACTER => ::TyranoDsl::WritingWords::ShowCharacter.new,
          START_SCENE => ::TyranoDsl::WritingWords::StartScene.new,
      }
    end

    # @param [ParsingContext] parsing_context
    # @return [TyranoDsl::WritingContext]
    # @raise [TyranoDsl::TyranoException]
    def write(parsing_context)
      log {'Writing content'}
      world = parsing_context.world
      writing_context = ::TyranoDsl::WritingContext.new(world)
      write_characters(writing_context, world)
      write_backgrounds(writing_context, world)
      write_scenes(writing_context, parsing_context)
      writing_context.end_writing
      log {'Content written'}
      writing_context
    end

    private

    # @param [TyranoDsl::WritingContext] writing_context
    # @param [TyranoDsl::Elements::World] world
    # @return [void]
    # @raise [TyranoDsl::TyranoException]
    def write_characters(writing_context, world)
      character_writer = ::TyranoDsl::ElementsWriters::CharacterWriter.new
      writing_context.file_actions.concat(character_writer.init_actions)
      world.characters.each_value do |character|
        writing_context.file_actions.concat(character_writer.write(world, character))
      end
    end

    # @param [TyranoDsl::WritingContext] writing_context
    # @param [TyranoDsl::Elements::World] world
    # @return [void]
    # @raise [TyranoDsl::TyranoException]
    def write_backgrounds(writing_context, world)
      background_writer = ::TyranoDsl::ElementsWriters::BackgroundWriter.new
      writing_context.file_actions.concat(background_writer.init_actions)
      world.backgrounds.each_value do |background|
        writing_context.file_actions.concat(background_writer.write(world, background))
      end
    end

    # @param [TyranoDsl::WritingContext] writing_context
    # @param [TyranoDsl::ParsingContext] parsing_context
    # @return [void]
    # @raise [TyranoDsl::TyranoException]
    def write_scenes(writing_context, parsing_context)
      parsing_context.words.each do |parsed_word|
        action_word = @words[parsed_word.word]
        unless action_word
          raise "Unknown word [#{action_word}]"
        end
        action_word.run(
            writing_context,
            parsing_context.world,
            parsed_word.word_location,
            parsed_word.parameters
        )
      end
    end

    def log
      @logger.info(self.class) {yield}
    end

  end
end