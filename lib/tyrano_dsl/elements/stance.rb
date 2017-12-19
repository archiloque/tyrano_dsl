require_relative 'elements_module'

# A stance
class TyranoDsl::Elements::Stance

  # @return [String]
  attr_reader :name
  # @return [String]
  attr_reader :original_file_name
  # @return [String]
  attr_reader :short_target_file_name
  # @return [String]
  attr_reader :long_target_file_name

  # @param [String] name
  # @param [String] original_file_name
  # @param [String] short_target_file_name
  # @param [String] long_target_file_name
  def initialize(name, original_file_name, short_target_file_name, long_target_file_name)
    @name = name
    @original_file_name = original_file_name
    @short_target_file_name = short_target_file_name
    @long_target_file_name = long_target_file_name
  end

end
