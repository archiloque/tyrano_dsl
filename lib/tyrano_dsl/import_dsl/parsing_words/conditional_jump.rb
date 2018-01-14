require_relative '../../elements/jump_target'

module TyranoDsl::ImportDsl::ParsingWords::ConditionalJump

  VALID_OPERATORS = [
      '<',
      '>',
      '==',
      '!=',
  ]

  # @param [String] variable
  # @param [String] operator
  # @param [String, Symbol, Float] value
  # @param [String] scene_name
  # @param [String, nil] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def conditional_jump(variable, operator, value, scene_name, label_name = nil)
    check_variable_exist(variable)
    if value.is_a?(String) || value.is_a?(Symbol)
      check_variable_exist(value)
    end
    unless VALID_OPERATORS.include? operator
      raise TyranoDsl::TyranoException, "Unknown operator [#{operator}]"
    end
    add_parsed_word(
        TyranoDsl::Vocabulary::CONDITIONAL_JUMP,
        variable: variable,
        operator: operator,
        value: value,
        scene_name: scene_name,
        label_name: label_name
    )
    label = label_name ? context.world.label_value(label_name) : nil
    context.world.jump_targets << TyranoDsl::Elements::JumpTarget.new(scene_name, label)
  end
end
