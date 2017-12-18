require_relative 'elements_module'

# A label
# @attr [String] name
# @attr [String] target_name
class TyranoDsl::Elements::Label

  attr_reader :name, :target_name

  def initialize(name, target_name)
    @name = name
    @target_name = target_name
  end

end