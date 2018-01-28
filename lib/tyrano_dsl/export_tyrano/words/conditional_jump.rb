require_relative 'base_word'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::ConditionalJump < TyranoDsl::ExportTyrano::Words::BaseWord

  OPERATORS_RUBY_TO_TYRANO = {
      '<' => '<',
      '>' => '>',
      '==' => '=',
      '!=' => '<>',
  }

  # @param [TyranoDsl::Validation::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :scene_name
  # @option parameters [String|nil] :label_name
  # @option parameters [String] :operator
  # @option parameters [String] :variable
  # @option parameters [String|Symbol|Float] :value
  # @return [void]
  def run(context, world, parameters)
    operator = parameters[:operator]
    variable = parameters[:variable]
    value = parameters[:value]
    scene_name = parameters[:scene_name]
    label_name = parameters[:label_name]

    variable_target = context.mangled_variable_name(variable)
    if value.is_a?(String) || value.is_a?(Symbol)
      value_target = "f.#{context.mangled_variable_name(value)}"
    else
      value_target = value
    end
    mangled_scene = context.mangled_scene_name(scene_name)
    mangled_label = label_name ? context.mangled_label_name(scene_name, label_name) : 'cond'
    tyrano_operator = OPERATORS_RUBY_TO_TYRANO[operator]

    context.append_content(
        "[jump storage=\"#{mangled_scene}\.ks\" target=\"#{mangled_label}\" cond=\"f.#{variable_target}#{tyrano_operator}#{value_target}\"]"
    )
  end

end
