module TyranoDsl

  module Elements

    # A declared scene
    # @attr [String] name
    # @attr [String] target_name
    class Scene

      attr_reader :name, :target_name

      # @param [String] name
      def initialize(name, index)
        @name = name
        @target_name = "scene#{index}"
      end

    end
  end

end