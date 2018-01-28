module TyranoDsl::ImportDsl::Words::UpdateVariable

  # @param [String] variable
  # @param [String] operator
  # @param [String|Symbol|Float] value
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def update_variable(variable, operator, value)
    add_parsed_word(
        TyranoDsl::Vocabulary::UPDATE_VARIABLE,
        variable: variable.to_s,
        operator: operator,
        value: value
    )
  end
end
