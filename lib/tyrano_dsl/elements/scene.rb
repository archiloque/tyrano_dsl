require_relative 'elements'

# A  scene
class TyranoDsl::Elements::Scene

  # @return [String]
  attr_reader :name

  # @return [Array<String>]
  attr_reader :labels

  # @param [String] name
  def initialize(name)
    @name = name
    @labels = []
  end

end
