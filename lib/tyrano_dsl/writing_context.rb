require 'logger'
require 'set'

require_relative 'elements_writers/scene_writer'
require_relative 'tyrano_exception'

module TyranoDsl

  # Context for writing
  # @attr [Hash{String => Object}] file_actions
  # @attr [TyranoDsl::Element::World] world
  # @attr [Array<String>] current_scene_content
  class WritingContext

    attr_reader :file_actions, :world, :current_scene_content

    def initialize(world)
      @logger = Logger.new(STDOUT)
      @world = world
      @file_actions = []
      @current_scene_content = nil
      @current_scene_name = nil
      @current_scene_assets = nil
      @current_scene_labels = nil
      @scene_writer = TyranoDsl::ElementsWriters::SceneWriter.new
    end

    # Append some content to the current scene
    #
    # @param [Array<Thread::Backtrace::Location>] word_location
    # @param [Array<String>] content
    # @return [void]
    # @raise [TyranoDsl::TyranoException]
    def append_content(word_location, content)
      check_in_scene(word_location)
      @current_scene_content << content
    end

    # Add an asset to be loaded in the current scene
    #
    # @param [Array<Thread::Backtrace::Location>] word_location
    # @param [String] asset_content
    # @return [void]
    # @raise [TyranoDsl::TyranoException]
    def add_asset_loading(word_location, asset_content)
      check_in_scene(word_location)
      @current_scene_assets << asset_content
    end

    # Add an label in the current scene
    #
    # @param [Array<Thread::Backtrace::Location>] word_location
    # @param [String] label_name
    # @return [void]
    # @raise [TyranoDsl::TyranoException]
    def add_label(word_location, label_name)
      check_in_scene(word_location)
      if @current_scene_labels.include? label_name
        raise TyranoDsl::TyranoException, "Duplicated label [#{label_name}] line #{word_location[0].lineno}"
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

    # @param [Array<Thread::Backtrace::Location>] word_location
    # @return [void]
    # @raise [TyranoDsl::TyranoException]
    def check_in_scene(word_location)
      unless @current_scene_content
        raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} this action should take place in a scene"
      end
    end

  end
end
