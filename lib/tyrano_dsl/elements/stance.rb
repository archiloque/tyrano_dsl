require_relative 'elements'

# A stance
class TyranoDsl::Elements::Stance

  # @return [String]
  attr_reader :name

  # @return [String]
  attr_reader :file_name

  # @param [String] name
  # @param [String] file_name
  def initialize(name, file_name)
    @name = name
    @file_name = file_name
  end

end
