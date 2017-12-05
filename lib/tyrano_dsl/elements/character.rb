module TyranoDsl

  module Elements

    # A declared character
    # @attr [String] name
    # @attr [Hash{String => String}] stances
    # @attr [String] images_dir
    class Character

      attr_reader :name
      attr_reader :images_dir
      attr_reader :stances

      # @param [String] name
      # @param [Hash{String => String}] images_dir
      # @param [String] stances
      def initialize(name, images_dir, stances)
        @name = name
        @images_dir = images_dir
        @stances = stances
      end

    end
  end

end