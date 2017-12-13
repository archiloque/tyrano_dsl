module TyranoDsl

  module Elements

    # A declared scene
    # @attr [String] name
    # @attr [String] target_name
    # @attr [Array<String>] labels
    class Scene

      attr_reader :name, :target_name, :labels

      # @param [String] name
      # @param [Integer] index
      def initialize(name, index)
        @name = name
        @target_name = "scene#{index}"
        @labels = []
      end

    end
  end

end