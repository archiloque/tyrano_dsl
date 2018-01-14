require 'logger'
require 'set'

require_relative '../tyrano_dsl'
require_relative '../tyrano_exception'
require_relative 'elements_writers/scene_writer'

# Context for writing
class TyranoDsl::ExportTyrano::WritingContext

  # @return [Array<String>]
  attr_reader :current_scene_assets
  # @return [Array<String>]
  attr_reader :current_scene_content
  # @return [Hash{String => Object}]
  attr_reader :file_actions
  # @return [TyranoDsl::Elements::World]
  attr_reader :world

  # @param [TyranoDsl::Elements::World] world
  def initialize(world)
    @logger = Logger.new(STDOUT)
    @world = world
    @file_actions = []
    @current_scene_content = nil
    @current_scene_name = nil
    @current_scene_assets = nil
    @current_scene_labels = nil
    @scene_writer = TyranoDsl::ExportTyrano::ElementsWriters::SceneWriter.new
  end

  # Append some content to the current scene
  #
  # @param [Array<String>] word_location
  # @param [Array<String>] content
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def append_content(word_location, content)
    check_in_scene(word_location)
    @current_scene_content << content
  end

  # Add an asset to be loaded in the current scene
  #
  # @param [Array<String>] word_location
  # @param [String] asset_content
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def add_asset_loading(word_location, asset_content)
    check_in_scene(word_location)
    @current_scene_assets << asset_content
  end

  # Add an label in the current scene
  #
  # @param [Array<String>] word_location
  # @param [String] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def add_label(word_location, label_name)
    check_in_scene(word_location)
    if @current_scene_labels.include? label_name
      raise TyranoDsl::TyranoException, "Duplicated label [#{label_name}]"
    end
    @current_scene_labels << label_name
  end

  # Initialize a new scene
  # @param [String] scene_name the scene name
  # @return [void]
  def init_new_scene(scene_name)
    write_current_scene
    @current_scene_content = []
    @current_scene_name = scene_name
    @current_scene_assets = Set.new
    @current_scene_labels = []
  end

  # Bookkeeping stuff to end the writing
  # @raise [TyranoDsl::TyranoException]
  # @return [void]
  def end_writing
    write_current_scene
    @current_scene_content = nil
    @current_scene_name = nil
    @current_scene_assets = nil
    @current_scene_labels = nil
    @world.validate
    log {"Writing is over, #{@file_actions.length} actions created"}
  end

  private

  def write_current_scene
    if @current_scene_name
      current_scene = @world.scenes[@current_scene_name]
      @file_actions.concat @scene_writer.write(
          current_scene,
          @current_scene_content,
          @current_scene_assets
      )
      @current_scene_labels.each do |label|
        current_scene.labels << label
      end
    end
  end

  def log
    @logger.info(self.class) {yield}
  end

  # @param [Array<String>] word_location
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def check_in_scene(word_location)
    unless @current_scene_content
      exception = TyranoDsl::TyranoException.new('This action should take place in a scene')
      exception.set_backtrace word_location
      raise exception
    end
  end

end