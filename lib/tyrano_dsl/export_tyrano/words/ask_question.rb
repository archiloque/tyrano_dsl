require_relative 'base_word'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::AskQuestion < TyranoDsl::ExportTyrano::Words::BaseWord

  def run(context, _world, parameters)
    content = []
    parameters[:possible_answers].each do |possible_answer|
      text = possible_answer[:text]
      scene_name = possible_answer[:scene]
      label_name = possible_answer[:label]
      top = possible_answer[:top]
      left = possible_answer[:left]

      mangled_scene = context.mangled_scene_name(scene_name)
      mangled_label = label_name ? context.mangled_label_name(scene_name, label_name) : ''

      content << "[glink color=\"black\" storage=\"#{mangled_scene}\" target=\"#{mangled_label}\" size=\"20\" x=\"#{left}\" y=\"#{top}\" text=\"#{h(text)}\"]\n"
    end
    content << "[s]\n"
    context.append_content(
        content.join
    )
  end

end