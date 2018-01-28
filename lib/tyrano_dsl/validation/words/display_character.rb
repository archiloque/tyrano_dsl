require_relative 'empty_word'

class TyranoDsl::Validation::Words::DeclareCharacter < TyranoDsl::Validation::Words::EmptyWord

  # @param [TyranoDsl::Validation::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @return [void]
  def world_construction_phase(context, world, word_location, parameters)
    character_name = parameters[:character_name]
    if character_name
      check_character_exist(world, word_location, character_name)
    end
  end

end