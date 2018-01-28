require_relative 'empty_word'

class TyranoDsl::Intermediate::Words::HideCharacter < TyranoDsl::Intermediate::Words::EmptyWord

  # @param [TyranoDsl::Intermediate::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @return [void]
  def validation_phase(context, world, word_location, parameters)
    check_character_exist(world, word_location, parameters[:character_name])
  end

end