require 'logger'

require_relative 'writing_context'
require_relative 'writers/background_writer'
require_relative 'writers/character_writer'

require_relative 'vocabulary'
TyranoDsl::Vocabulary::ALL_WORDS.each do |word|
  require_relative "actions/#{word}"
end

module TyranoDsl
  class Writer

    include Vocabulary

    def initialize()
      @logger = Logger.new(STDOUT)
      @words = {
          DECLARE_BACKGROUND => ::TyranoDsl::Actions::DeclareBackground.new,
          DECLARE_CHARACTER => ::TyranoDsl::Actions::DeclareCharacter.new,
          DISPLAY_TEXT => ::TyranoDsl::Actions::DisplayText.new,
          JUMP_TO => ::TyranoDsl::Actions::JumpTo.new,
          SET_BACKGROUND => ::TyranoDsl::Actions::SetBackground.new,
          SET_CHARACTER_STANCE => ::TyranoDsl::Actions::SetCharacterStance.new,
          SHOW_CHARACTER => ::TyranoDsl::Actions::ShowCharacter.new,
          START_SCENE => ::TyranoDsl::Actions::StartScene.new,
      }
    end

    def log()
      @logger.info(self.class){yield}
    end

    # @param [!ParsingContext] parsing_context
    # @return [!TyranoDsl::WritingContext]
    # @raise [TyranoDsl::TyranoException]
    def write(parsing_context)
      log{'Writing content'}
      world = parsing_context.world
      writing_context = ::TyranoDsl::WritingContext.new(world)
      write_characters(writing_context, world)
      write_backgrounds(writing_context, world)
      write_scenes(writing_context, parsing_context)
      writing_context.end_writing
      log{'Content written'}
      writing_context
    end

    private

    # @param [TyranoDsl::WritingContext] writing_context
    # @param [TyranoDsl::Elements::World] world
    # @return [void]
    # @raise [TyranoDsl::TyranoException]
    def write_characters(writing_context, world)
      character_writer = ::TyranoDsl::Writers::CharacterWriter.new
      world.characters.each_value do |character|
        writing_context.actions.concat(character_writer.write(world, character))
      end
    end

    # @param [TyranoDsl::WritingContext] writing_context
    # @param [TyranoDsl::Elements::World] world
    # @return [void]
    # @raise [TyranoDsl::TyranoException]
    def write_backgrounds(writing_context, world)
      background_writer = ::TyranoDsl::Writers::BackgroundWriter.new
      writing_context.actions.concat(background_writer.init_actions)
      world.backgrounds.each_value do |background|
        writing_context.actions.concat(background_writer.write(world, background))
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

  end
end