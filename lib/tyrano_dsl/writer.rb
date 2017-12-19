require 'logger'

require_relative 'elements_writers/background_writer'
require_relative 'elements_writers/character_writer'
require_relative 'elements_writers/characters_writer'
require_relative 'elements_writers/title_screen_writer'
require_relative 'elements_writers/variables_writer'
require_relative 'tyrano_dsl'
require_relative 'vocabulary'
require_relative 'writing_context'

# Write the content that have been parsed
class TyranoDsl::Writer

  include TyranoDsl::Vocabulary

  def initialize
    @logger = Logger.new(STDOUT)
    @words = {}
    TyranoDsl::Vocabulary.get_words_class('writing_words') do |word, word_class|
      @words[word] = word_class.new
    end
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [TyranoDsl::WritingContext]
  # @raise [TyranoDsl::TyranoException]
  def write(world, parsed_words)
    log {'Writing content'}
    writing_context = TyranoDsl::WritingContext.new(world)
    write_title_screen(writing_context, world)
    write_backgrounds(writing_context, world)
    write_characters(writing_context, world)
    write_scenes(writing_context, world, parsed_words)
    write_variables(writing_context, world)
    writing_context.end_writing
    log {'Content written'}
    writing_context
  end

  private

  # @param [TyranoDsl::WritingContext] writing_context
  # @param [TyranoDsl::Elements::World] world
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def write_title_screen(writing_context, world)
    title_screen_writer = TyranoDsl::ElementsWriters::TitleScreenWriter.new
    concat_file_actions(writing_context, title_screen_writer.write(world))
  end

  # @param [TyranoDsl::WritingContext] writing_context
  # @param [TyranoDsl::Elements::World] world
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def write_characters(writing_context, world)
    character_writer = TyranoDsl::ElementsWriters::CharacterWriter.new
    concat_file_actions(writing_context, character_writer.init_actions)
    world.characters.each_value do |character|
      concat_file_actions(writing_context, character_writer.write(character))
    end
    characters_writer = TyranoDsl::ElementsWriters::CharactersWriter.new
    concat_file_actions(writing_context, characters_writer.write(world))
  end

  # @param [TyranoDsl::WritingContext] writing_context
  # @param [TyranoDsl::Elements::World] world
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def write_backgrounds(writing_context, world)
    background_writer = TyranoDsl::ElementsWriters::BackgroundWriter.new
    concat_file_actions(writing_context, background_writer.init_actions)
    world.backgrounds.each_value do |background|
      concat_file_actions(writing_context, background_writer.write(background))
    end
  end

  # @param [TyranoDsl::WritingContext] writing_context
  # @param [TyranoDsl::Elements::World] world
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def write_variables(writing_context, world)
    variables_writer = TyranoDsl::ElementsWriters::VariablesWriter.new
    concat_file_actions(writing_context, variables_writer.write(world))
  end

  # @param [TyranoDsl::WritingContext] writing_context
  # @param [Array] file_actions
  # @return [void]
  def concat_file_actions(writing_context, file_actions)
    writing_context.file_actions.concat(file_actions)
  end

  # @param [TyranoDsl::WritingContext] writing_context
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @param [TyranoDsl::Elements::World] world
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def write_scenes(writing_context, world, parsed_words)
    parsed_words.each do |parsed_word|
      action_word = @words[parsed_word.word]
      action_word.run(
          writing_context,
          world,
          parsed_word.word_location,
          parsed_word.parameters
      )
    end
  end

  def log
    @logger.info(self.class) {yield}
  end

end