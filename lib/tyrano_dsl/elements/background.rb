module TyranoDsl

  module Elements


    # A declared background
    # @attr [String] name
    # @attr [String] image_path
    # @attr [String] target_short_file_name
    # @attr [String] target_long_file_name
    class Background

      attr_reader :name, :image_path, :target_short_file_name, :target_long_file_name

      BACKGROUND_DIRECTORY = File.join('data', 'bgimage')

      # @param [String] name
      # @param [String] image_path
      # @param [Integer] index
      def initialize(name, image_path, index)
        @name = name
        @image_path = image_path
        @index = index
        @target_short_file_name = "#{index}#{File.extname(image_path)}"
        @target_long_file_name = File.join(
            BACKGROUND_DIRECTORY,
            @target_short_file_name
        )
      end

    end
  end

end