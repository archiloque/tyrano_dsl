require_relative 'elements'

# A jump target
class TyranoDsl::Elements::JumpTarget

  # @return [String]
  attr_reader :scene

  # @return [String,nil]
  attr_reader :label

  # @return [Array<String>]
  attr_reader :word_location

  # @param [String] scene
  # @param [Array<String>] word_location
  # @param [TyranoDsl::Elements::Label|nil] label
  def initialize(scene, label, word_location)
    @scene = scene
    @label = label
    @word_location = word_location
  end

end
