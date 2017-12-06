require 'logger'

require_relative 'tyrano_exception'
require_relative 'writers/scene_writer'

module TyranoDsl

  # Context for writing
  # @attr [Hash{String => Object}] actions
  # @attr [TyranoDsl::Element::World] world
  # @attr [Array<String>] current_scene_content
  class WritingContext

    attr_reader :actions, :world

    def initialize(world)
      @logger = Logger.new(STDOUT)
      @world = world
      @actions = []
      @current_scene_content = nil
      @current_scene_name = nil
      @scene_writer = TyranoDsl::Writers::SceneWriter.new
    end

    # Append some content to the current scene
    #
    # @param [Array<Thread::Backtrace::Location>] word_location
    # @param [Array<String>] content
    def append_to_current_scene(word_location, content)
      unless @current_scene_content
        raise ::TyranoDsl::TyranoException, "Invalid content line #{word_location.lineno} this action should take place in a scene"
      end
      @current_scene_content.concat(content)
    end

    # Initialize a new scene
    # @param [String] scene_name the scene name
    def init_new_scene(scene_name)
      if @current_scene_name
        @actions.concat @scene_writer.write(
            @world,
            @world.scenes[@current_scene_name],
            @current_scene_content
        )
      end
      @current_scene_content = []
      @current_scene_name = scene_name
    end

    def end_writing
      if @current_scene_name
        @actions.concat @scene_writer.write(
            @world,
            @world.scenes[@current_scene_name],
            @current_scene_content
        )
      end
      @current_scene_content = nil
      @current_scene_name = nil
      log {"Writing is over, #{@actions.length} actions created"}
    end

    private

    def log
      @logger.info(self.class) {yield}
    end

  end
end
