require 'logger'
require 'set'

require_relative 'writers/scene'
require_relative '../tyrano_constants'

# Context for writing
class TyranoDsl::ExportTyrano::Context

  BACKGROUND_IMAGE_DIRECTORY = File.join('data', 'bgimage')

  # @return [Array<String>]
  attr_reader :current_scene_assets
  # @return [Array<String>]
  attr_reader :current_scene_content
  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
  attr_reader :file_actions
  # @return [TyranoDsl::Elements::World]
  attr_reader :world
  # @return [Hash{String=>Integer}]
  attr_reader :character_indexes
  # @return [Hash{String=>String}]
  attr_reader :backgrounds_short_file_names
  # @return [Hash{String=>String}]
  attr_reader :backgrounds_long_file_names


  # @param [TyranoDsl::Elements::World] world
  def initialize(world)
    @logger = Logger.new(STDOUT)
    @world = world

    @file_actions = []

    @current_scene_content = nil
    @current_scene_name = nil
    @current_scene_assets = nil

    @mangled_labels_names = {}
    @mangled_scenes_names = {}
    @mangled_variables_names = {}

    @character_indexes = {}
    @stances_long_file_names = {}
    @stances_short_file_names = {}

    @backgrounds_short_file_names = {}
    @backgrounds_long_file_names = {}
    @scene_writer = TyranoDsl::ExportTyrano::Writers::Scene.new
  end

  def after_setup

    world.characters.values.each_with_index do |character, character_index|
      character.stances.values.each_with_index do |stance, stance_index|
        @character_indexes[character.name] = character_index + 1
        image_id = "#{character.name}##{stance.name}"
        short_file_name = File.join((character_index + 1).to_s,
                                    "#{stance_index.to_s}#{File.extname(stance.file_name)}")
        @stances_short_file_names[image_id] = short_file_name
        long_file_name = File.join(
            *(TyranoDsl::TyranoConstants::CHARACTER_IMAGE_FULL_DIRECTORY + [short_file_name])
        )
        @stances_long_file_names[image_id] = long_file_name

      end
    end

    world.backgrounds.values.each_with_index do |background, background_index|
      target_short_file_name = "#{background_index + 1}#{File.extname(background.image_path)}"
      @backgrounds_short_file_names[background.name] = target_short_file_name
      @backgrounds_long_file_names[background.name] = File.join(
          BACKGROUND_IMAGE_DIRECTORY,
          target_short_file_name
      )
    end
  end

  # @param [String] character_name
  # @param [String] stance_name
  # @return [String]
  def stance_long_file_name(character_name, stance_name)
    @stances_long_file_names["#{character_name}##{stance_name}"]
  end

  # @param [String] character_name
  # @param [String] stance_name
  # @return [String]
  def stance_short_file_name(character_name, stance_name)
    @stances_short_file_names["#{character_name}##{stance_name}"]
  end

  # Append some content to the current scene
  #
  # @param [Array<String>] content
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def append_content(content)
    @current_scene_content << content
  end

  # Add an asset to be loaded in the current scene
  #
  # @param [String] asset_content
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def add_asset_loading(asset_content)
    @current_scene_assets << asset_content
  end

  # Initialize a new scene
  # @param [String] scene_name the scene name
  # @return [void]
  def init_new_scene(scene_name)
    write_current_scene
    @current_scene_content = []
    @current_scene_name = scene_name
    @current_scene_assets = Set.new
  end

  # Bookkeeping stuff to end the writing
  # @raise [TyranoDsl::TyranoException]
  # @return [void]
  def end_writing
    write_current_scene
    @current_scene_content = nil
    @current_scene_name = nil
    @current_scene_assets = nil
    log {"Writing is over, #{@file_actions.length} actions created"}
  end

  # @param [String] scene_name
  # @param [String] label_name
  # @return [String]
  def mangled_label_name(scene_name, label_name)
    label_key = "#{scene_name}##{label_name}"
    if @mangled_labels_names.key? label_key
      @mangled_labels_names[label_key]
    else
      technical_name = "label_#{@mangled_labels_names.length}"
      @mangled_labels_names[label_key] = technical_name
      technical_name
    end
  end

  # @param [String] scene_name
  # @return [String]
  def mangled_scene_name(scene_name)
    mangled_value(@mangled_scenes_names, scene_name, 'scene')
  end

  # @param [String] variable_name
  # @return [String]
  def mangled_variable_name(variable_name)
    mangled_value(@mangled_variables_names, variable_name, 'variable_')
  end

  private

  # @param [Hash{String=>String}] holding_hash
  # @param [String] key
  # @param [String] prefix
  # @return [String]
  def mangled_value(holding_hash, key, prefix)
    if holding_hash.key? key
      holding_hash[key]
    else
      technical_name = "#{prefix}#{holding_hash.length + 1}"
      holding_hash[key] = technical_name
      technical_name
    end
  end

  def write_current_scene
    if @current_scene_name
      current_scene = @world.scenes[@current_scene_name]
      @file_actions.concat @scene_writer.write(
          mangled_scene_name(current_scene.name),
          @current_scene_content,
          @current_scene_assets
      )
    end
  end

  def log
    @logger.info(self.class) {yield}
  end

end