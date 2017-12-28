require_relative 'elements_module'

# A variable
class TyranoDsl::Elements::Variable

  # @return [String]
  attr_reader :name
  # @return [String]
  attr_reader :target_name
  # @return [Integer]
  attr_reader :initial_value

  # @param [String] name
  # @param [String] target_name
  # @param [String] initial_value
  def initialize(name, target_name, initial_value)
    @name = name
    @target_name = target_name
    @initial_value = initial_value
  end

end