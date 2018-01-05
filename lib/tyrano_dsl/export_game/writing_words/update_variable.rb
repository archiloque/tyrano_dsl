require_relative 'writing_words_module'

class TyranoDsl::ExportGame::WritingWords::UpdateVariable

  include TyranoDsl::ExportGame::WritingWords::WritingWordsModule

  def run(writing_context, world, word_location, parameters)
    operator = parameters[:operator]
    variable = parameters[:variable]
    value = parameters[:value]
    variable_target = world.variables[variable].target_name
    if value.is_a?(String) || value.is_a?(Symbol)
      val = world.variables[value].target_name
      value_target = "f.#{val}"
      op = 'h'
    else
      val = value
      value_target = value
      op = 't'
    end

    writing_context.append_content(
        word_location,
        "[tb_eval  exp=\"f.#{variable_target}#{operator}#{value_target}\"  name=\"#{variable_target}\"  cmd=\"#{operator}\"  op=\"#{op}\"  val=\"#{val}\"  val_2=\"undefined\"]"
    )
  end

end
