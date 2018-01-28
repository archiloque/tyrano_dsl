require 'logger'

require_relative '../tyrano_dsl'
require_relative '../vocabulary'
require_relative 'elements_writers/background_writer'
require_relative 'elements_writers/character_writer'
require_relative 'elements_writers/characters_writer'
require_relative 'elements_writers/title_screen_writer'
require_relative 'elements_writers/variables_writer'
require_relative 'context'

# Export content in Tyrano format
class TyranoDsl::ExportTyrano::Main

  def initialize
    @logger = Logger.new(STDOUT)
    @words = {}
    TyranoDsl::Vocabulary.get_words_class('export_tyrano/words') do |word, word_class|
      @words[word] = word_class.new
    end
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
  # @raise [TyranoDsl::TyranoException]
  def run(world, parsed_words)
    log {'Writing content'}
    context = TyranoDsl::ExportTyrano::Context.new(world)
    context.after_setup
    write_title_screen(context, world)
    write_backgrounds(context, world)
    write_characters(context, world)
    write_scenes(context, world, parsed_words)
    write_variables(context, world)
    context.end_writing
    log {'Content written'}
    context.file_actions
  end

  # @param [Array<TyranoDsl::FileActions::BaseFileAction>] file_actions
  # @param [String] export_path
  # @return [void]
  def apply(file_actions, export_path)
    file_actions.each do |file_action|
      file_action.run(export_path)
    end
  end

  private

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def write_title_screen(context, world)
    title_screen_writer = TyranoDsl::ExportTyrano::ElementsWriters::TitleScreenWriter.new
    concat_file_actions(context, title_screen_writer.write(context, world))
  end

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def write_characters(context, world)
    character_writer = TyranoDsl::ExportTyrano::ElementsWriters::CharacterWriter.new
    concat_file_actions(context, character_writer.init_actions)
    world.characters.each_value do |character|
      concat_file_actions(context, character_writer.write(context, character))
    end
    characters_writer = TyranoDsl::ExportTyrano::ElementsWriters::CharactersWriter.new
    concat_file_actions(context, characters_writer.write(context, world))
  end

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def write_backgrounds(context, world)
    background_writer = TyranoDsl::ExportTyrano::ElementsWriters::BackgroundWriter.new
    concat_file_actions(context, background_writer.init_actions)
    world.backgrounds.each_value do |background|
      concat_file_actions(context, background_writer.write(context, background))
    end
  end

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def write_variables(context, world)
    variables_writer = TyranoDsl::ExportTyrano::ElementsWriters::VariablesWriter.new
    concat_file_actions(context, variables_writer.write(context, world))
  end

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [Array] file_actions
  # @return [void]
  def concat_file_actions(context, file_actions)
    context.file_actions.concat(file_actions)
  end

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @param [TyranoDsl::Elements::World] world
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def write_scenes(context, world, parsed_words)
    parsed_words.each do |parsed_word|
      action_word = @words[parsed_word.word]
      action_word.run(
          context,
          world,
          parsed_word.parameters
      )
    end
  end

  def log
    @logger.info(self.class) {yield}
  end

end