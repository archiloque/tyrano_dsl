module TyranoDsl

  module Elements


    # A declared jump target
    # @attr [String] scene
    # @attr [String] label
    class JumpTarget

      attr_reader :scene, :label

      # @param [String] scene
      # @param [String] label
      def initialize(scene, label)
        @scene = scene
        @label = label
      end

    end
  end

end