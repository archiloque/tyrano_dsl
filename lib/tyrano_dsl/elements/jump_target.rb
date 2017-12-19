require_relative 'elements_module'

# A declared jump target
class TyranoDsl::Elements::JumpTarget

  # @return [String]
  attr_reader :scene
  # @return [TyranoDsl::Elements::Label|nil]
  attr_reader :label

  # @param [String] scene
  # @param [TyranoDsl::Elements::Label|nil] label
  def initialize(scene, label)
    @scene = scene
    @label = label
  end

end
