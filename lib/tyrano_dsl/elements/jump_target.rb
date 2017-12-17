module TyranoDsl

  module Elements


    # A declared jump target
    # @attr [String] scene
    # @attr [TyranoDsl::Elements::Label|nil] label
    class JumpTarget

      attr_reader :scene, :label

      # @param [String] scene
      # @param [TyranoDsl::Elements::Label|nil] label
      def initialize(scene, label)
        @scene = scene
        @label = label
      end

    end
  end

end