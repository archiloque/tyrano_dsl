require_relative 'validation'

# Context for validation
class TyranoDsl::Validation::Context

  # @return [TyranoDsl::Element::Scene]
  attr_accessor :current_scene

  def initialize
    @current_scene = nil
  end

end