module TyranoDsl::ImportDsl::Words::ConditionalJump

  # @param [String] variable
  # @param [String] operator
  # @param [String, Symbol, Float] value
  # @param [String] scene_name
  # @param [String, nil] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def conditional_jump(variable, operator, value, scene_name, label_name = nil)
    add_parsed_word(
        TyranoDsl::Vocabulary::CONDITIONAL_JUMP,
        variable: variable.to_s,
        operator: operator,
        value: value,
        scene_name: scene_name,
        label_name: label_name
    )
  end
end
