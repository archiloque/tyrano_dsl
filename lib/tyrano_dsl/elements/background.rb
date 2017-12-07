module TyranoDsl

  module Elements


    # A declared background
    # @attr [String] name
    # @attr [String] image_path
    # @attr [String] target_file_name
    class Background

      attr_reader :name, :image_path, :target_file_name

      BACKGROUND_DIRECTORY = 'bgimage'

      def initialize(name, image_path, index)
        @name = name
        @image_path = image_path
        @index = index
        @target_file_name = "#{index}#{File.extname(image_path)}"
      end

    end
  end

end