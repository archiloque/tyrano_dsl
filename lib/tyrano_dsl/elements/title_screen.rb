module TyranoDsl

  module Elements

    # the title screen
    # @attr [String] background
    # @attr [String] first_scene_name
    class TitleScreen

      attr_accessor :background, :first_scene_name

      def initialize
        @background = nil
        @first_scene_name = nil
      end

    end
  end

end