require_relative '../../elements/variable'

module TyranoDsl::ImportDsl::Words::DeclareVariable

  # @param [String\Symbol] variable_name
  # @param [Float] initial_value
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_variable(variable_name, initial_value)
    add_parsed_word(
        TyranoDsl::Vocabulary::DECLARE_VARIABLE,
        variable_name: variable_name.to_s,
        initial_value: initial_value,
        )
  end

end
