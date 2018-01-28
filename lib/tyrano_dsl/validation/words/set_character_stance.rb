require_relative 'empty_word'

class TyranoDsl::Validation::Words::SetCharacterStance < TyranoDsl::Validation::Words::EmptyWord

  # @param [TyranoDsl::Validation::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :character_name
  # @option parameters [String] :stance
  # @return [void]
  def validation_phase(context, world, word_location, parameters)
    check_character_exist(
        world,
        word_location,
        parameters[:character_name],
        parameters[:stance])
  end

end