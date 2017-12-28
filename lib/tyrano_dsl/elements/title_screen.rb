require_relative 'elements_module'

# The title screen
class TyranoDsl::Elements::TitleScreen

  # @return [String]
  attr_accessor :background
  # @return [String]
  attr_accessor :first_scene_name

  def initialize
    @background = nil
    @first_scene_name = nil
  end

end
