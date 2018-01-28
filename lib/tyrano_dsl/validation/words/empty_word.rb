require_relative '../../tyrano_exception'
require_relative 'words'

class TyranoDsl::Validation::Words::EmptyWord

  # @param [TyranoDsl::Validation::Context] _context
  # @param [TyranoDsl::Elements::World] _world
  # @param [Array<String>] _word_location
  # @param [Hash{Symbol=>Object}] _parameters
  # @return [void]
  def world_construction_phase(_context, _world, _word_location, _parameters)
  end

  # @param [TyranoDsl::Validation::Context] _context
  # @param [TyranoDsl::Elements::World] _world
  # @param [Array<String>] _word_location
  # @param [Hash{Symbol=>Object}] _parameters
  # @return [void]
  def validation_phase(_context, _world, _word_location, _parameters)
  end

  protected

  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [String] character_name
  # @param [String, nil] character_stance
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def check_character_exist(world, word_location, character_name, character_stance = nil)
    character = world.characters[character_name]
    unless character
      TyranoDsl::TyranoException.raise_exception "Unknown character [#{character_name}]", word_location
    end
    if character_stance && !character.stances.key?(character_stance)
      TyranoDsl::TyranoException.raise_exception "Unknown stance [#{character_stance}]", word_location
    end
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [String] variable_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def check_variable_exist(world, word_location, variable_name)
    unless world.variables.key? variable_name
      TyranoDsl::TyranoException.raise_exception "Unknown variable [#{variable_name}]", word_location
    end
  end

end