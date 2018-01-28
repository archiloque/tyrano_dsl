require 'logger'

require_relative 'export_dsl'
require_relative '../file_actions/file_copy'
require_relative '../file_actions/create_file'

class TyranoDsl::ExportDsl::Context

  # @return [TyranoDsl::Elements::World]
  attr_reader :world

  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
  attr_reader :file_actions

  def initialize(world)
    @logger = Logger.new(STDOUT)
    @world = world
    @file_actions = []
    @current_scene_content = nil
    @current_scene_name = nil
    @main_ruby_file_declaration_content = []
    @main_ruby_file_inclusion_content = []
    @scenes_names_to_filenames = {}
    @images_names_to_filenames = {}
    @scenes_names_to_filenames['main'] = 'main.rb'
  end

  # @param [Array<String>] content
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def add_declaration(content)
    @main_ruby_file_declaration_content << content
  end

  # Append some content to the current scene
  #
  # @param [Array<String>] word_location
  # @param [Array<String>] content
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def append_content_current_scene(word_location, content)
    @current_scene_content << content
  end

  # Initialize a new scene
  # @param [String] scene_name the scene name
  # @return [void]
  def init_new_scene(scene_name)
    write_current_scene
    @current_scene_content = []
    @current_scene_name = scene_name
    @main_ruby_file_inclusion_content << "include_file #{scene_file_name(scene_name).inspect}"
  end

  # Bookkeeping stuff to end the writing
  # @raise [TyranoDsl::TyranoException]
  # @return [void]
  def end_writing
    write_current_scene
    @current_scene_content = nil
    @current_scene_name = nil
    @current_scene_assets = nil
    @file_actions << TyranoDsl::FileActions::CreateFile.new(
        'main.rb',
        (@main_ruby_file_declaration_content.sort + @main_ruby_file_inclusion_content).join("\n")
    )
    log {"Writing is over, #{@file_actions.length} actions created"}
  end

  # @param [String] scene_name
  # @return [String]
  def scene_file_name(scene_name)
    if @scenes_names_to_filenames.key? scene_name
      return @scenes_names_to_filenames[scene_name]
    end
    possible_scene_filename = "#{TyranoDsl::FileActions.sanitize_filename(scene_name)}.rb"
    while @scenes_names_to_filenames.value?(possible_scene_filename)
      possible_scene_filename = "_#{possible_scene_filename}"
    end
    @scenes_names_to_filenames[scene_name] = possible_scene_filename
    possible_scene_filename
  end


  # @param [String] directory
  # @param [String] image_path
  # @return [String]
  def image_file_name(directory, image_path)
    key = File.join(directory, image_path)
    if @images_names_to_filenames.key? key
      return @scenes_names_to_filenames[key]
    end
    possible_image_filename = "#{TyranoDsl::FileActions.sanitize_filename(image_path)}"
    possible_image_full_path = File.join(directory, possible_image_filename)
    while @scenes_names_to_filenames.value?(File.join(directory, possible_image_filename))
      possible_image_filename = "_#{possible_image_filename}"
      possible_image_full_path = File.join(directory, possible_image_filename)
    end
    @scenes_names_to_filenames[key] = possible_image_full_path
    possible_image_full_path
  end

  # @param [String] from
  # @param [String] to
  # @return [void]
  def add_file_copy(from, to)
    @file_actions << TyranoDsl::FileActions::FileCopy.new(
        from,
        to
    )
  end


  private

  # @return [void]
  def write_current_scene
    if @current_scene_name
      @file_actions << TyranoDsl::FileActions::CreateFile.new(
          scene_file_name(@current_scene_name),
          @current_scene_content.join("\n")
      )
    end
  end

  # @return [void]
  def log
    @logger.info(self.class) {yield}
  end

end