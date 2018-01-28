require_relative 'empty_word'

class TyranoDsl::Intermediate::Words::UpdateVariable < TyranoDsl::Intermediate::Words::EmptyWord

  VALID_OPERATORS = [
      '=',
      '+=',
      '-=',
      '*=',
      '/=',
      '%=',
  ]

  # @param [TyranoDsl::Intermediate::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :operator
  # @option parameters [String] :variable
  # @option parameters [String] :value
  # @return [void]
  def validation_phase(context, world, word_location, parameters)
    operator = parameters[:operator]
    unless VALID_OPERATORS.include? operator
      TyranoDsl::TyranoException.raise_exception "Unknown operator [#{operator}]", word_location
    end

    check_variable_exist(world, word_location, parameters[:variable])

    value = parameters[:value]
    if value.is_a?(String) || value.is_a?(Symbol)
      check_variable_exist(world, word_location, value)
    end
  end

end