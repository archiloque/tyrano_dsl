require_relative 'base_word'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::UpdateVariable < TyranoDsl::ExportTyrano::Words::BaseWord

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDSL::Elements::World] world
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :operator
  # @option parameters [String] :variable
  # @option parameters [String] :value
  # @return [void]
  def run(context, world, parameters)
    operator = parameters[:operator]
    variable = parameters[:variable]
    value = parameters[:value]
    variable_target = context.mangled_variable_name(variable)
    if value.is_a?(String) || value.is_a?(Symbol)
      val = context.mangled_variable_name(value)
      value_target = "f.#{val}"
      op = 'h'
    else
      val = value
      value_target = value
      op = 't'
    end

    context.append_content(
        "[tb_eval  exp=\"f.#{variable_target}#{operator}#{value_target}\"  name=\"#{variable_target}\"  cmd=\"#{operator}\"  op=\"#{op}\"  val=\"#{val}\"  val_2=\"undefined\"]"
    )
  end

end
