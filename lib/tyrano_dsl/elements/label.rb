module TyranoDsl
  module Elements

    # A label
    # @attr [String] name
    # @attr [String] target_name
    class Label

      attr_reader :name, :target_name

      def initialize(name, target_name)
        @name = name
        @target_name = target_name
      end

    end

  end
end
