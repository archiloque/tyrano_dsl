module TyranoDsl::ParsingWords::UpdateVariable

  VALID_OPERATORS = [
      '=',
      '+=',
      '-=',
      '*=',
      '/=',
      '%=',
  ]

  # @param [String] variable
  # @param [String] operator
  # @param [String|Symbol|Float] value
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def update_variable(variable, operator, value)
    check_variable_exist(variable)
    if value.is_a?(String) || value.is_a?(Symbol)
      check_variable_exist(value)
    end
    unless VALID_OPERATORS.include? operator
      raise TyranoDsl::TyranoException, "Unknown operator [#{operator}]"
    end
    add_parsed_word(
        TyranoDsl::Vocabulary::UPDATE_VARIABLE,
        variable: variable,
        operator: operator,
        value: value
    )
  end
end
