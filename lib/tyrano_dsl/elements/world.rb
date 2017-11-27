module TyranoDsl

  module Elements

    class World

      attr_reader :scenes
      attr_reader :characters
      attr_reader :backgrounds

      def initialize
        @scenes = {}
        @characters = {}
        @backgrounds = {}
      end

      def validate
      end

    end

  end
end