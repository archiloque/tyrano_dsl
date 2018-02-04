require_relative '../../elements/variable'

module TyranoDsl::ImportDsl::Words::DeclareVariable

  # @param [String\Symbol] variable_name
  # @param [Float|String|nil] initial_value
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_variable(variable_name, initial_value = nil)
    parameters = {
        variable_name: variable_name.to_s,
    }
    if initial_value
      parameters[:initial_value] = initial_value
    end
    add_parsed_word(
        TyranoDsl::Vocabulary::DECLARE_VARIABLE,
        parameters
    )
  end

end
