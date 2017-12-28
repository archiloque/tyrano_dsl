require_relative '../elements/variable'

module TyranoDsl::ParsingWords::DeclareVariable

  # @param [String\Symbol] variable_name
  # @param [Float] initial_value
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_variable(variable_name, initial_value)
    if context.world.variables.key? variable_name
      raise TyranoDsl::TyranoException, "Duplicated variable [#{variable_name}]"
    else
      context.world.variables[variable_name] = TyranoDsl::Elements::Variable.new(
          variable_name,
          "variable_#{context.world.variables.length + 1}",
          initial_value
      )
    end
    add_parsed_word(
        TyranoDsl::Vocabulary::DECLARE_VARIABLE,
        variable_name: variable_name,
        initial_value: initial_value,
        )
  end

end
