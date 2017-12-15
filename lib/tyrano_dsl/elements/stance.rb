module TyranoDsl
  module Elements

    # A stance
    # @attr [String] name
    # @attr [String] original_file_name
    # @attr [String] short_target_file_name
    # @attr [String] long_target_file_name
    class Stance

      attr_reader :name, :original_file_name, :short_target_file_name, :long_target_file_name

      def initialize(name, original_file_name, short_target_file_name, long_target_file_name)
        @name = name
        @original_file_name = original_file_name
        @short_target_file_name = short_target_file_name
        @long_target_file_name = long_target_file_name
      end

    end

  end
end
