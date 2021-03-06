require_relative 'empty_word'

class TyranoDsl::Intermediate::Words::DeclareVariable < TyranoDsl::Intermediate::Words::EmptyWord

  # @param [TyranoDsl::Intermediate::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :variable_name
  # @option parameters [Float\String|nil] :initial_value
  # @return [void]
  def world_construction_phase(context, world, word_location, parameters)
    variable_name = parameters[:variable_name]

    if world.variables.key? variable_name
      raise TyranoDsl::TyranoException, "Duplicated variable [#{variable_name}]", word_location
    end
    ['\'', '"'].each do |forbidden_character|
      if variable_name.include?(forbidden_character)
        raise TyranoDsl::TyranoException, "Variable name should not contain [#{forbidden_character}] [#{variable_name}]", word_location
      end
    end

    world.variables[variable_name] = TyranoDsl::Elements::Variable.new(
        variable_name,
        parameters[:initial_value]
    )
  end

end