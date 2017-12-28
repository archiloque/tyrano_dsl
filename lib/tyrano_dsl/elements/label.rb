require_relative 'elements_module'

# A label
class TyranoDsl::Elements::Label

  # @return [String]
  attr_reader :name
  # @return [String]
  attr_reader :target_name

  # @param [String] name
  # @param [String] target_name
  def initialize(name, target_name)
    @name = name
    @target_name = target_name
  end

end