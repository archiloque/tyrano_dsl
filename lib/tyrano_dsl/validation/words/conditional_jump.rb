require_relative '../../elements/jump_target'
require_relative 'empty_word'

class TyranoDsl::Validation::Words::ConditionalJump < TyranoDsl::Validation::Words::EmptyWord

  VALID_OPERATORS = [
      '<',
      '>',
      '==',
      '!=',
  ]

  # @param [TyranoDsl::Validation::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :scene_name
  # @option parameters [String|nil] :label_name
  # @option parameters [String] :operator
  # @option parameters [String] :variable
  # @option parameters [String|Symbol|Float] :value
  # @return [void]
  def world_construction_phase(context, world, word_location, parameters)
    world.jump_targets << TyranoDsl::Elements::JumpTarget.new(
        parameters[:scene_name],
        parameters[:label_name],
        word_location)
  end

  # @param [TyranoDsl::Validation::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :scene_name
  # @option parameters [String|nil] :label_name
  # @option parameters [String] :operator
  # @option parameters [String] :variable
  # @option parameters [String|Symbol|Float] :value
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