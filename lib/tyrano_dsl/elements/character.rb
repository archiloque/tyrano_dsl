module TyranoDsl

  module Elements

    # A declared character
    # @attr [String] name
    # @attr [Hash{String => String}] stances
    # @attr [Hash{String => String}] stances_target_long_files_names
    class Character

      CHARACTER_DIRECTORY = File.join('data', 'fgimage', 'chara')


      attr_reader :name, :stances, :default_stance_target_short_file_name, :stances_target_long_files_names

      # @param [String] name
      # @param [String] stances
      # @param [Integer] index
      def initialize(name, stances, index)
        @name = name
        @stances = stances
        @index = index
        @stances_target_long_files_names = {}
        stances.each_pair do |stance_name, stance_file|
          short_file_name = File.join(index.to_s,
                                      "#{@stances_target_long_files_names.length}#{File.extname(stance_file)}")
          if [:default, 'default'].include? stance_name
            @default_stance_target_short_file_name = short_file_name
          end
          @stances_target_long_files_names[stance_name] = File.join(
              CHARACTER_DIRECTORY, short_file_name)
        end
      end

    end
  end

end