module TyranoDsl

  module Elements

    class Game

      attr_reader :scenes
      attr_reader :characters
      attr_reader :background

      def initialize
        @scenes = {}
        @characters = {}
        @background = {}
      end

      def validate
      end

    end

  end
end