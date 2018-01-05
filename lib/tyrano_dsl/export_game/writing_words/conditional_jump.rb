require_relative 'writing_words_module'

class TyranoDsl::ExportGame::WritingWords::ConditionalJump

  include TyranoDsl::ExportGame::WritingWords::WritingWordsModule

  OPERATORS_RUBY_TO_TYRANO = {
      '<' => '<',
      '>' => '>',
      '==' => '=',
      '!=' => '<>',
  }

  def run(writing_context, world, word_location, parameters)
    operator = parameters[:operator]
    variable = parameters[:variable]
    value = parameters[:value]
    scene_name = parameters[:scene_name]
    label_name = parameters[:label_name]

    variable_target = world.variables[variable].target_name
    if value.is_a?(String) || value.is_a?(Symbol)
      value_target = "f.#{world.variables[value].target_name}"
    else
      value_target = value
    end
    target_scene = fetch_scene(world, word_location, scene_name)
    label = label_name ? world.labels[label_name].target_name : 'cond'
    tyrano_operator = OPERATORS_RUBY_TO_TYRANO[operator]

    writing_context.append_content(
        word_location,
        "[jump storage=\"#{target_scene.target_name}\.ks\" target=\"#{label}\" cond=\"f.#{variable_target}#{tyrano_operator}#{value_target}\"]"
    )
  end

end
