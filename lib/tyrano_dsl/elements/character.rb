module TyranoDsl

  module Elements

    # A declared character
    # @attr [String] name
    # @attr [Hash{String => String}] stances
    # @attr [String] images_dir
    # @attr [Hash{String => String}] stances_target_long_files_names
    class Character

      CHARACTER_DIRECTORY = File.join('fgimage')

      attr_reader :name, :images_dir, :stances, :stances_target_long_files_names

      # @param [String] name
      # @param [Hash{String => String}] images_dir
      # @param [String] stances
      # @param [Integer] index
      def initialize(name, images_dir, stances, index)
        @name = name
        @images_dir = images_dir
        @stances = stances
        @index = index
        @stances_target_long_files_names = {}
        stances.each_pair do |stance_name, stance_file|
          @stances_target_long_files_names[stance_name] = File.join(
              CHARACTER_DIRECTORY,
              index.to_s,
              "#{@stances_target_long_files_names.length}#{File.extname(stance_file)}"
          )
        end
      end

    end
  end

end