require_relative 'empty_word'

class TyranoDsl::Validation::Words::SetTitleScreenBackground < TyranoDsl::Validation::Words::EmptyWord

  # @param [TyranoDsl::Validation::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @return [void]
  def validation_phase(context, world, word_location, parameters)
    background_name = parameters[:background_name]
    unless world.backgrounds.key? background_name
      TyranoDsl::TyranoException.raise_exception "Unknown background [#{background_name}]", word_location
    end
    if world.title_screen.background
      TyranoDsl::TyranoException.raise_exception 'Title screen background already defined', word_location
    end
    world.title_screen.background = background_name
  end

end