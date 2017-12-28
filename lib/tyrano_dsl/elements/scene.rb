require_relative 'elements_module'

# A  scene
class TyranoDsl::Elements::Scene

  # @return [String]
  attr_reader :name
  # @return [String]
  attr_reader :target_name
  # @return [Array<String>]
  attr_reader :labels

  # @param [String] name
  # @param [Integer] index
  def initialize(name, index)
    @name = name
    @target_name = "scene#{index}"
    @labels = []
  end

end
