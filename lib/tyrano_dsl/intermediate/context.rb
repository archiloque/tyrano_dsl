require_relative 'intermediate'

# Context for intermediate pass
class TyranoDsl::Intermediate::Context

  # @return [TyranoDsl::Element::Scene]
  attr_accessor :current_scene

  def initialize
    @current_scene = nil
  end

end