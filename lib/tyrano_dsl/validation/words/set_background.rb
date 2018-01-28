require_relative 'empty_word'

class TyranoDsl::Validation::Words::SetBackground < TyranoDsl::Validation::Words::EmptyWord

  # @param [TyranoDsl::Validation::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters$
  # @option parameters [String] :background_name
  # @return [void]
  def validation_phase(context, world, word_location, parameters)
    background_name = parameters[:background_name]
    unless world.backgrounds.key? background_name
      TyranoDsl::TyranoException.raise_exception "Unknown background [#{background_name}]", word_location
    end
  end

end