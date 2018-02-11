require 'set'

require_relative 'import_tyrano'
require_relative 'readers/scene'
require_relative '../tyrano_constants'

# Context for parsing, used by words to store content
class TyranoDsl::ImportTyrano::Context

  # @return [Hash{String=>TyranoDsl::ImportTyrano::Character}]
  attr_reader :characters

  # @return [String\nil]
  attr_accessor :current_scene_file

  # @return [Array<String>|nil]
  attr_accessor :current_scene_content

  # @return [Integer|nil]
  attr_accessor :current_scene_line_index

  # @return [Array<TyranoDsl::ParsedWord>|nil]
  attr_accessor :current_scene_words

  # @param [String] directory_path
  # @param [Array<TyranoDsl::ImportTyrano::Character>] characters
  # @param [TyranoDsl::ImportTyrano::FileAccessor] file_accessor
  def initialize(directory_path, characters, file_accessor)
    @directory_path = directory_path
    @characters = {}

    @scenes_to_load = Set.new
    @scenes_to_load << 'title_screen'
    @processed_scenes = []

    @file_accessor = file_accessor
    characters.each do |character|
      @characters[character.name] = character
    end

    @current_scene_file = nil
    @current_scene_content = nil
    @current_scene_line_index = nil
    @current_scene_words = nil
  end

  # @return [String]
  def current_line
    @current_scene_content[@current_scene_line_index]
  end

  # @return [void]
  def go_next_line
    @current_scene_line_index += 1
  end

  # @param [String] scene_name
  # @return [void]
  def register_scene(scene_name)
    unless @processed_scenes.include? scene_name
      @scenes_to_load << scene_name
    end
  end

  # Add a parsed word
  # @param [String] word
  # @param [Hash{String => Object}] parameters
  # @return [void]
  def add_parsed_word(word, parameters = {})
    @current_scene_words << TyranoDsl::ParsedWord.new(
        word,
        ["#{@current_scene_file}:#{@current_scene_line_index}"],
        parameters
    )
  end

  # @param [String] file_path
  # @return [String]
  # @raise [TyranoDsl::TyranoException]
  def file_full_path(file_path)
    absolute_path = File.absolute_path(file_path, @directory_path)
    unless File.exist?(absolute_path)
      raise TyranoDsl::TyranoException, "Missing file [#{absolute_path}]"
    end
    absolute_path
  end

  # @return [Array<TyranoDsl::ParsedWord>]
  def process_scenes
    result = []
    scene_reader = TyranoDsl::ImportTyrano::Readers::Scene.new
    until @scenes_to_load.empty?
      current_scene_name = @scenes_to_load.first
      result.concat(scene_reader.read(@file_accessor, current_scene_name, self))
      @scenes_to_load.delete(current_scene_name)
      @processed_scenes << current_scene_name
    end
    result
  end

  # @return [Array<TyranoDsl::ParsedWord>]
  def process_characters
    characters.values.collect do |character|
      stances_full_pathes = {}
      character.stances.each_pair do |name, value|
        stances_full_pathes[name] = file_full_path(File.join(TyranoDsl::TyranoConstants::CHARACTER_IMAGE_DIRECTORY, value))
      end
      TyranoDsl::ParsedWord.new(
          TyranoDsl::Vocabulary::DECLARE_CHARACTER,
          [],
          character_name: character.name,
          stances: stances_full_pathes,
          )
    end

  end

end