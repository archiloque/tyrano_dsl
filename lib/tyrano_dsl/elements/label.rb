module TyranoDsl
  module Elements

    # A label
    # @attr [String] name
    # @attr [String] technical_name
    class Label

      attr_reader :name, :technical_name

      def initialize(name, technical_name)
        @name = name
        @technical_name = technical_name
      end

    end

  end
end
