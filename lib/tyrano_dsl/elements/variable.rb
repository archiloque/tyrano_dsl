require_relative 'elements'

# A variable
class TyranoDsl::Elements::Variable

  # @return [String]
  attr_reader :name

  # @return [Integer]
  attr_reader :initial_value

  # @param [String] name
  # @param [String] initial_value
  def initialize(name, initial_value)
    @name = name
    @initial_value = initial_value
  end

end