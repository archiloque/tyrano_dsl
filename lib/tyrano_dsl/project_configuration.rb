
module TyranoDsl

  # Configuration of the Tyrano project
  # @attr [Integer] screen_height
  # @attr [Integer] screen_width
  class ProjectConfiguration

    attr_reader :screen_height, :screen_width

    # @param [Hash] builder_configuration
    def initialize(builder_configuration)
      @screen_height = builder_configuration['width']
      @screen_width = builder_configuration['height']
    end

  end
end
